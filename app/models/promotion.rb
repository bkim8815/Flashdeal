class Promotion < ActiveRecord::Base
  belongs_to :customer
  belongs_to :coupon
end
