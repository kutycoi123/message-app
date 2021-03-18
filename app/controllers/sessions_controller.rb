class SessionsController < ApplicationController
  
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

end
