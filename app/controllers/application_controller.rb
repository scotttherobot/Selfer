class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_admin
  helper_method :require_login

  private

  def current_user
     # @current_user ||= User.find_by(session: session[:token]) if session[:token]
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_admin
      if !current_user.is_admin
         redirect_to login_url, :notice => "Admin permission required"
      end
  end

  def require_login
     if !current_user
        redirect_to login_url, :notice => "You must login first!"
     end
  end
end
