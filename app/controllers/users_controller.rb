class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save 
      render "show"
    else
      render "new"
    end
  end
  
  def show
  
  
  end
  
  def edit
  
  
  end
  
  def update
  
  
  end
  
  def index
  
  
  end

  # TODO implement delete/destroy when admins are set up

end
