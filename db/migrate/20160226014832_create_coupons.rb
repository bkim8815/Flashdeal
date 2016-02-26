class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :title
      t.decimal :price
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :expiration
      t.integer :max_count
      t.belongs_to :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
