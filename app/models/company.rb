class Company < ApplicationRecord
  VALID_DOMAIN_REGEX = /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}\z/ix

  scope :ordered, -> { order(name: :asc) }

  belongs_to :user
  belongs_to :tenant, optional: true
  has_many :pages, dependent: :destroy
  has_and_belongs_to_many :industries, -> { distinct }
  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :domain, presence: true, length: { minimum: 3, maximum: 64 },
                     format: { with: VALID_DOMAIN_REGEX }
  mount_uploader :logo, CompanyLogoUploader
end
