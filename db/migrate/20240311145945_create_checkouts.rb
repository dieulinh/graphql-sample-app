class CreateCheckouts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkouts do |t|
      t.string :payment_intent
      t.string :redirect_status
      t.string :checkout_id
      t.timestamps
    end
  end
end
