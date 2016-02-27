class Phone < ActiveRecord::Base
  has_many :coupons, through: :promotions
end
