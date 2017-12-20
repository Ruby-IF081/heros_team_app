# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string
#  last_name              :string
#  role                   :integer          default("admin")
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  tenant_id              :integer
#

class User < ApplicationRecord
  ROLES = { sale: 0, admin: 1, moderator: 2 }.freeze
  enum role: ROLES
  has_many :companies, dependent: :destroy
  validates :first_name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :last_name,  length: { minimum: 3, maximum: 50 }, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
