class CreateSeats < ActiveRecord::Migration[5.0]
  def change
    create_table :seats do |t|
      t.string :seat_no
      t.integer :room_id

      t.timestamps
    end
  end
end
