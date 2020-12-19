class CreateCourseAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :course_attachments do |t|
      t.bigint :course_id
      t.string :avatar
      t.timestamps
    end
  end
end
