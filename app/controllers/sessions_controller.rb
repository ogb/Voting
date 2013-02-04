class SessionsController < ApplicationController
  
  def new
    redirect_to current_user if current_user
  end
  
  def create
    # upon login
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Successfully logged in"
    else
      flash.now[:error] = "Your login information is invalid. Try again."
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end
  
  
end
