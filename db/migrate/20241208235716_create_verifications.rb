class CreateVerifications < ActiveRecord::Migration[6.0]
  def change
    create_table :verifications do |t|
      t.string :email
      t.string :code
      t.datetime :expires_at

      t.timestamps
    end
  end
end
