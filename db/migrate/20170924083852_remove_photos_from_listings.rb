class RemovePhotosFromListings < ActiveRecord::Migration[5.1]
  def change
    remove_column :listings, :photos, :json
  end
end
