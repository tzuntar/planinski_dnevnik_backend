class Peak < ApplicationRecord
  belongs_to :country, optional: true

  validates :name, presence: true, uniqueness: {scope: :country_id, case_sensitive: false}
end
