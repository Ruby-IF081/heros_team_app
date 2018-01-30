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
  SOCIAL_LINKS = %w[twitter facebook linkedincompany youtube angellist owler crunchbasecompany
                    pinterest google klout].freeze

  scope :ordered, -> { order(name: :asc) }

  belongs_to :user
  belongs_to :tenant, optional: true
  has_many   :pages, dependent: :destroy
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :videos, as: :videoable, dependent: :destroy
  has_and_belongs_to_many :industries, -> { distinct }

  mount_uploader :logo, CompanyLogoUploader

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :domain, presence: true, length: { minimum: 3, maximum: 64 },
                     format: { with: VALID_DOMAIN_REGEX }

  def socials
    SOCIAL_LINKS.select { |social| social if self[social].present? }
  end
end
