class CreateJournalEntryReactions < ActiveRecord::Migration[8.1]
  def change
    create_table :journal_entry_reactions do |t|
      t.references :journal_entry, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :type

      t.timestamps
    end
  end
end
