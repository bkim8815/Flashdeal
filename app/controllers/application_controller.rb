class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_restaurant

  def current_restaurant
    @current_restaurant ||= Restaurant.find_by(id: session[:restaurant_id])
  end

  def require_logged_in
    return true if current_restaurant

    return redirect_to 'http://www.google.com'

  end

end
