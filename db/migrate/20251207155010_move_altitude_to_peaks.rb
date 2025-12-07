class MoveAltitudeToPeaks < ActiveRecord::Migration[8.1]
  def change
    remove_column :journal_entries, :altitude
    add_column :peaks, :altitude, :integer
  end
end
