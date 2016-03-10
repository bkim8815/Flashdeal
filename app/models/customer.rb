class Customer < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :restaurants, through: :subscriptions
end
