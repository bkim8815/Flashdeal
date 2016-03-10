require 'spec_helper'
require 'customer'

describe Customer do
  it "is has my number" do
    customer=Customer.new
    customer.phone_number.should == "5852172719"
  end








end
