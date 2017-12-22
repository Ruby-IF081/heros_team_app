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
#

class User < ApplicationRecord
  SALE_ROLE = 'sale'.freeze
  ADMIN_ROLE = 'admin'.freeze
  MODERATOR_ROLE = 'moderator'.freeze
  ROLES = [SALE_ROLE, ADMIN_ROLE, MODERATOR_ROLE].freeze
  has_many :companies, dependent: :destroy
  belongs_to :tenant, optional: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, length: { minimum: 3, maximum: 50 }, presence: true
  validates :last_name,  length: { minimum: 3, maximum: 50 }, presence: true
end
