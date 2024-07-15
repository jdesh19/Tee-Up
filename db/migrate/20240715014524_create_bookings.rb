class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tee_time, null: false, foreign_key: true
      t.integer :player_count

      t.timestamps
    end
  end
end
