class UsersController < ApplicationController
  
  before_filter :check_session, only: [:index, :show, :edit, :new]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render "new"
    end
  end
  
  def show
   @user = User.find_by_id(params[:id])
   redirect_to current_user unless authorize(@user)
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    redirect_to current_user unless authorize(@user)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def index
    if current_user.is? "administrator"
      @users = User.all
    else
      flash.now[:error] = "Not authorized"
      redirect_to current_user
    end
  end
  
  def destroy
    if current_user.is? "moderator"
      User.find_by_id(params[:id]).destroy
      flash.notice = "Deleted user"
      redirect_to current_user
    end
  
  end

end
