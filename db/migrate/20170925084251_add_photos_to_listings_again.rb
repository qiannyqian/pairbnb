class AddPhotosToListingsAgain < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :photos, :json
  end
end
