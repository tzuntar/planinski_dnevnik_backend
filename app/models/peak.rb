class Peak < ApplicationRecord
  belongs_to :country, optional: true

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
