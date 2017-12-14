class User < ApplicationRecord
  ROLES = { sale: 0, admin: 1, moderator: 2 }.freeze
  enum role: ROLES
  validates :first_name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :last_name,  length: { minimum: 3, maximum: 50 }, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
