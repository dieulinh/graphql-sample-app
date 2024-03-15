class AddDataToCheckouts < ActiveRecord::Migration[6.0]
  def change
    add_column :checkouts, :client_secret, :string
    add_column :checkouts, :payment_intent_secret, :string
  end
end
