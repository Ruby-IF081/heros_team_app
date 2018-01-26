# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string
#  domain            :string
#  youtube           :string
#  twitter           :string
#  linkedincompany   :string
#  facebook          :string
#  angellist         :string
#  owler             :string
#  crunchbasecompany :string
#  pinterest         :string
#  google            :string
#  klout             :string
#  overview          :string
#  founded           :integer
#  approx_employees  :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#  logo              :string
#

class Company < ApplicationRecord
  VALID_DOMAIN_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}\z/ix

  scope :ordered, -> { order(name: :asc) }

  belongs_to :user
  belongs_to :tenant, optional: true
  has_many   :pages, dependent: :destroy
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :videos, as: :videoable
  has_and_belongs_to_many :industries, -> { distinct }

  mount_uploader :logo, CompanyLogoUploader

  after_create :create_video

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :domain, presence: true, length: { minimum: 3, maximum: 64 },
                     format: { with: VALID_DOMAIN_REGEX }

  private

  def create_video
    if youtube.present?
      channel = authenticate
      channel_videos = get_videos(channel)
      channel_videos.each do |vid|
        videos.build(title: vid.title, embed_code: get_embed_code(vid.id))
      end
    end
  end

  def get_videos(channel)
    channel.videos
  end

  def authenticate
    Yt.configuration.api_key = Rails.application.secrets.google_api_key
    Yt::Channel.new id: youtube.split('channel/').last
  end

  def get_embed_code(id)
    "<iframe src='https://www.youtube.com/embed/" + id.to_s +
      "?rel=0' frameborder='0' allow='autoplay; encrypted-media' allowfullscreen></iframe>"
  end
end
