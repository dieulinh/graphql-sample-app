class CreateWorkHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :work_histories do |t|
      t.integer :mentor_id
      t.string :company_name
      t.string :position
      t.date :start_date
      t.date :end_date
      t.text :responsibilities
      t.timestamps
    end
  end
end
