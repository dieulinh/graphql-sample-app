class AddStudentIdToMentors < ActiveRecord::Migration[6.0]
  def change
    add_column :mentors, :student_id, :integer
  end
end
