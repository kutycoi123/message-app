class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]  
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user and user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in successfully"
      redirect_to root_path
    else
      flash.now[:error] = "There was some erros with your login details"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully!"
    redirect_to login_path
  end

  private
  def logged_in_redirect
    if logged_in?
      flash[:error] = "You are already logged in"
      redirect_to root_path
    end
  end

end
