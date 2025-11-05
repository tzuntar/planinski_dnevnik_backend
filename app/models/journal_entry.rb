class JournalEntry < ApplicationRecord
  belongs_to :peak
  belongs_to :user

  has_many :journal_entry_reactions

  validates :name, presence: true
  validates_presence_of :peak
  validates_presence_of :user
end
