class AddCountryToMentors < ActiveRecord::Migration[6.0]
  def change
    add_column :mentors, :country, :string
    add_column :mentors, :skills, :text, array: true, default: []
    add_index :mentors, :country
  end
end
