class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :email
      t.string :username
      t.string :title
      t.text :teaching_experience
      t.timestamp
    end
  end
end
