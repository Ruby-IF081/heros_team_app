class User < ApplicationRecord
  ROLES = { sale: 0, admin: 1, moderator: 2 }.freeze
  enum role: ROLES
  before_save { email.downcase! }
  validates :first_name,
            presence: true,
            length: { minimum: 3, maximum: 50 }
  validates :last_name,
            presence: true,
            length: { minimum: 3, maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
