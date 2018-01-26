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
    channel = authenticate
    channel_videos = channel.videos
    channel_videos.each do |vid|
      # binding.pry
      videos.build(title: vid.title,
                embed_code: "<iframe src='https://www.youtube.com/embed/#{vid.id}?rel=0&autoplay=<%= params[:autoplay] || 0 %>' frameborder='0' allowfullscreen></iframe>")
    end
    save
  end

  def authenticate
    Yt.configuration.api_key = Rails.application.secrets.google_api_key
    Yt::Channel.new id: youtube.split('channel/').last
  end
end
