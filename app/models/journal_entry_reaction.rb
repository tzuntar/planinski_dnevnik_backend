class JournalEntryReaction < ApplicationRecord
  belongs_to :journal_entry
  belongs_to :user

  validates_presence_of :journal_entry
  validates_presence_of :user
end
