class UpdateStudents < ActiveRecord::Migration[5.2]
  def change
    add_column :students, :last_login, :datetime
    add_column :students, :reset_password_token, :string
    add_column :students, :reset_password_sent_at, :datetime
  end
end
