class DropNullReqOnCountryOnPeaks < ActiveRecord::Migration[8.1]
  def change
    change_column_null :peaks, :country_id, true
  end
end
