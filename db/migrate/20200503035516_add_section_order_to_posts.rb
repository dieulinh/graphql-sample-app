class AddSectionOrderToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :section_order, :integer
    add_column :posts, :course_id, :integer
    add_index :posts, :course_id
  end
end
