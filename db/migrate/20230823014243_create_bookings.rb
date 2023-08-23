class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.string :mentor_id
      t.string :student_id
      t.integer :slot
      t.date :booking_date

      t.timestamps
    end
  end
end
