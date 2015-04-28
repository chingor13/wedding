class SessionsController < ApplicationController

  # GET /login
  def new

  end

  # GET /logout
  def destroy
    logout_user
    redirect_to root_path
  end

  # GET /auth/:provider/callback
  def callback
    login_user(User.find_or_create_from_auth_hash(auth_hash))
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end