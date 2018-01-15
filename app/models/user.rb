class User < ApplicationRecord
  SALE_ROLE        = 'sale'.freeze
  ADMIN_ROLE       = 'admin'.freeze
  SUPER_ADMIN_ROLE = 'super_admin'.freeze
  ROLES            = [SALE_ROLE, ADMIN_ROLE, SUPER_ADMIN_ROLE].freeze
  DEFAULT_PASSWORD = 'password'.freeze

  has_many :companies, dependent: :destroy
  has_many :visits, dependent: :destroy
  belongs_to :tenant, optional: true

  accepts_nested_attributes_for :tenant

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :tenant,     presence: true
  validates :role,       presence: true, inclusion: ROLES

  scope :by_date, -> { order(created_at: :asc) }

  delegate :name, to: :tenant, prefix: true, allow_nil: true

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def admin?
    role == User::ADMIN_ROLE
  end

  def super_admin?
    role == User::SUPER_ADMIN_ROLE
  end

  def privileged?
    admin? || super_admin?
  end
end
