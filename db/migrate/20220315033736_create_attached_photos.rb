class CreateAttachedPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :attached_photos do |t|
      t.string :photo
      t.timestamps
    end
  end
end
