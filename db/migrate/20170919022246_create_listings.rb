class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.references :user
      t.string :name
      t.string :place_type
      t.integer :room_number
      t.integer :bed_number
      t.integer :guest_number
      t.string :country
      t.string :state
      t.string :city
      t.string :address
      t.integer :price
      t.string :description

      t.timestamps
    end
  end
end
