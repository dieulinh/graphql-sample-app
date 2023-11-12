class AddShortDescriptionToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :short_description, :string
    add_index :articles, :short_description
  end
end
