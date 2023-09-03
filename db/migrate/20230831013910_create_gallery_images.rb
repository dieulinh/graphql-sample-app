class CreateGalleryImages < ActiveRecord::Migration[6.0]
  def change
    create_table :gallery_images do |t|
      t.integer :mentor_id
      t.string :title
      t.string :description
      t.string :image
      t.string :tags
      t.timestamps
    end
  end
end
