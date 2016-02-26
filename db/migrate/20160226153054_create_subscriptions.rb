class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.boolean :status
      t.belongs_to :restaurant, index: true, foreign_key: true
      t.belongs_to :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
