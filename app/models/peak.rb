class Peak < ApplicationRecord
  belongs_to :country

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
