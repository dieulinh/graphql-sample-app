class AddStudentIdToCheckouts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkouts,:student_id, :integer
  end
end
