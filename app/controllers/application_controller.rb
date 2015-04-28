class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  attr_accessor :current_user

  protected

  def authenticate_user!
    @current_user = session.has_key?(:user_id) ?
      User.find_by_id(session[:user_id]) :
      nil
  end

  def login_user(user)
    session[:user_id] = user.id
  end

  def logout_user
    session.clear
  end

end
