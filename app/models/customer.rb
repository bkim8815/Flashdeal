class Customer < ActiveRecord::Base
  has_many :coupons, through: :promotions
  has_many :restaurants, through: :subscriptions
end
