class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :description
      t.string :instructions
      t.string :preparation_time
      t.string :cooking_time
      t.string :total_time
      t.string :servings
      t.string :calories
      t.string :youtube_link
    end
  end
end
