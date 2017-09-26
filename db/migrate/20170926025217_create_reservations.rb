class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :user
      t.references :listing
      t.date :start_date
      t.date :end_date
      t.integer :price

      t.timestamps
    end
  end
end
