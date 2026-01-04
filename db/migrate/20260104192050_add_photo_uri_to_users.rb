class AddPhotoUriToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :photo_uri, :string
  end
end
