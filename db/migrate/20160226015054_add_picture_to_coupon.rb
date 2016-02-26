class AddPictureToCoupon < ActiveRecord::Migration
  def self.up
    add_attachment :coupons, :picture
  end

  def self.down
    remove_attachment :coupons, :picture
  end
end
