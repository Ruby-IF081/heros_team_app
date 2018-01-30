class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :tenant

  validates  :body, presence: true, length: { maximum: 400 }
  validates  :commentable, presence: true
  validates  :tenant_id, presence: true
  validates  :user_id, presence: true

  scope :recent, -> { order(created_at: :asc) }
end
