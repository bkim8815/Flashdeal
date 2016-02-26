class Email < ApplicationMailer
  default from: "no-reply@flashdeals.com"

def welcome(restaurant)
@restaurant = restaurant
mail(to: @restaurant.email, subject: 'Sample Email')
end
end
