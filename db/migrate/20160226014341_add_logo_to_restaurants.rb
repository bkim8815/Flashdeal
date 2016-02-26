class AddLogoToRestaurants < ActiveRecord::Migration
  def self.up
    add_attachment :restaurants, :logo
  end

  def self.down
    remove_attachment :restaurants, :logo
  end
end
