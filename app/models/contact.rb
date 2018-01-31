class Contact < ApplicationRecord
  VALID_EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, :phone, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEXP }, presence: true
  validates :message, length: { maximum: 3000 }, presence: true
end
