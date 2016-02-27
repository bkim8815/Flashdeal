class Promotion < ActiveRecord::Base
  belongs_to :phone
  belongs_to :coupon
end
