class User < ApplicationRecord
  validates :user_id, :password, presence: true
  validates :user_id, length: { in: 6..20 }
  validates :password, length: { in: 8..20 }
  validates :user_id, :password, uniqueness: true
  validates :user_id, format: { with: /\A[a-z0-9]+\z/i }
  validates :password, format: { with: /\A[a-z0-9]+\z/i }
  validates :nickname, length: { minimum: 30 }, allow_nil: true
  validates :comment, length: { maximum: 100 }, allow_nil: true
  has_secure_password
end
