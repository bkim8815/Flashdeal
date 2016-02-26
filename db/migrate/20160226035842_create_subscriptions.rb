class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :restaurant_id
      t.integer :customer_id
      t.boolean :status

      t.timestamps null: false
    end
  end
end
