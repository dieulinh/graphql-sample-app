class AddRolesToStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :roles, :string, array: true, default: []
    add_index :students, :roles, using: 'gin'
  end
end
