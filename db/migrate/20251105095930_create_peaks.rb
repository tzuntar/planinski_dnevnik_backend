class CreatePeaks < ActiveRecord::Migration[8.1]
  def change
    create_table :peaks do |t|
      t.string :name
      t.string :type
      t.text :description
      t.string :lat
      t.string :lon
      t.references :country, null: false, foreign_key: true

      t.timestamps
    end
  end
end
