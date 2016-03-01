class Email < ApplicationMailer
  default from: "flashdeal@doralworld.com"

def welcome(restaurant)
@restaurant = restaurant
mail(to: @restaurant.email, subject: 'Sample Email')
end
end
