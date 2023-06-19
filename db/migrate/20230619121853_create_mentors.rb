class CreateMentors < ActiveRecord::Migration[6.0]
  def change
    create_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address
      t.string :specialization
      t.string :experience_years
      t.text :bio

      t.timestamps
    end
  end
end
