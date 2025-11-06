class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  # Exclude sensitive fields from JSON serialization
  def as_json(options = {})
    super({ except: [ :password_digest ] }.merge(options))
  end
end
