class AddPromocodeToCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :promocode, :string
  end
end
