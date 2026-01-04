class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_many :journal_entries


  # Exclude sensitive fields from JSON serialization
  def as_json(options = {})
    super({ except: [ :password_digest ] }.merge(options))
  end
end
