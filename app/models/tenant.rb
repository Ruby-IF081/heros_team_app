class Tenant < ApplicationRecord
  VALID_WEBSITE_REGEX = /\A(www.)?[^_\W][-a-zA-Z0-9_]+\.+[-a-zA-Z0-9]+\z/i
  VALID_PHONE_REGEX = /\A[+]?[\d\-.() ]+\z/

  has_many :users, dependent: :destroy
  has_many :companies, through: :users
  has_one :owner, class_name: 'User'

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :website, length: { minimum: 3, maximum: 64 },
                      format:                 { with: VALID_WEBSITE_REGEX },
                      uniqueness:             { scope: :name, case_sensitive: false },
                      allow_blank: true
  validates :phone, length: { maximum: 32 }, format: { with: VALID_PHONE_REGEX }, allow_blank: true
end
