class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    # redirect to different page depending on role TODO
    if @user.save 
      session[:user_id] = @user.id
      redirect_to 
    else
      render "new"
    end

  end



end
