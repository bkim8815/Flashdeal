class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.integer :customer_id
      t.integer :coupon_id

      t.timestamps null: false
    end
  end
end
