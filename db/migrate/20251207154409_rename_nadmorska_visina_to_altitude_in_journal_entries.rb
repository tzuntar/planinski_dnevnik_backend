class RenameNadmorskaVisinaToAltitudeInJournalEntries < ActiveRecord::Migration[8.1]
  def change
    rename_column :journal_entries, :nadmorska_visina, :altitude
    remove_reference :journal_entries, :peak
    add_reference :journal_entries, :peak, null: true, foreign_key: true
  end
end
