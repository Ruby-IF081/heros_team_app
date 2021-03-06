# == Schema Information
#
# Table name: tenants
#
#  id         :integer          not null, primary key
#  name       :string
#  phone      :string
#  website    :string
#  logo       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :integer
#

class Tenant < ApplicationRecord
  VALID_WEBSITE_REGEX = /\A(www.)?[^_\W][-a-zA-Z0-9_]+\.+[-a-zA-Z0-9]+\z/i
  VALID_PHONE_REGEX = /\A[+]?[\d\-.() ]+\z/

  scope :ordered, -> { order(name: :asc) }

  has_many :users, dependent: :destroy
  has_many :companies, through: :users
  has_many :pages, through: :companies
  has_many :visits, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :owner, class_name: 'User'

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :website, length: { minimum: 3, maximum: 64 },
                      format:                 { with: VALID_WEBSITE_REGEX },
                      uniqueness:             { scope: :name, case_sensitive: false },
                      allow_blank: true
  validates :phone, length: { maximum: 32 }, format: { with: VALID_PHONE_REGEX }, allow_blank: true
end
