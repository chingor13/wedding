class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  attr_accessor :current_user
  helper_method :current_user

  protected

  def authenticate_user!
    @current_user = User.find_by_id(session[:user_id]) ||
      AnonymousUser.instance
  end

  def authorize!
    return if current_user.authenticated?
    
    redirect_to login_path, flash: {error: "You must log in before continuing."}
  end

  def authorize_as_admin!
    return if current_user.admin?

    redirect_to root_path, flash: {error: "You do not have permission to view this page."}
  end

  def login_user(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def logout_user
    session.clear
  end

end
