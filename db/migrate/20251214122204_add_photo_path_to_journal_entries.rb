class AddPhotoPathToJournalEntries < ActiveRecord::Migration[8.1]
  def change
    add_column :journal_entries, :photo_path, :string
  end
end
