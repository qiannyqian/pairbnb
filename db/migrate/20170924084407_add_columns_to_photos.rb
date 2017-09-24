class AddColumnsToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_reference :photos, :listing, foreign_key: true
    add_column :photos, :image, :string
  end
end
