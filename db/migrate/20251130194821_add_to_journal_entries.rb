class AddToJournalEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :journal_entries, :nadmorska_visina, :integer
  end
end
