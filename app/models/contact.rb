class Contact < ApplicationRecord
  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  VALID_PHONE_REGEXP = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/
  validates :name, presence: true
  validates :phone, format: { with: VALID_PHONE_REGEXP }, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEXP }, presence: true
  validates :message, length: { maximum: 3000 }, presence: true
end
