class CreateLearningProgress < ActiveRecord::Migration[6.0]
  def change
    create_table :learning_progresses do |t|
      t.integer :course_id
      t.integer :student_id
      t.integer :post_id
      t.boolean :completed
      t.timestamps
    end
  end
end
