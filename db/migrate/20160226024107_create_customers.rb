class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :phone_number
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end
