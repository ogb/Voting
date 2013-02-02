class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    # upon login
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      # TODO redirect to page depending on role
      redirect_to <>, notice: "Successfully logged in"
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
