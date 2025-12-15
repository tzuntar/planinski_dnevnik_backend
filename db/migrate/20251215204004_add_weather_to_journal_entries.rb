class AddWeatherToJournalEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :journal_entries, :weather, :text
  end
end
