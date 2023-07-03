class AddRateToMentors < ActiveRecord::Migration[6.0]
  def change
    add_column :mentors, :hourly_rate, :integer
  end
end
