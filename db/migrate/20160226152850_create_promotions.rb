class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :coupon, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
