class SessionsController < ApplicationController
  def new

  end

  def create
    @restaurant = Restaurant.find_by(email: params[:email]).try(:authenticate, params[:password])

    return render action: 'new' unless @restaurant

    session[:restaurant_id] = @restaurant.id
    redirect_to only_path(@restaurant)
  end



  def destroy
    session[:restaurant_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
