class UsersController < ApplicationController
  
  before_filter :check_session, only: [:index, :show, :edit, :new]
  
  def new
    if current_user.is? :moderator or current_user.is? :administrator
      @user = User.new
    else
      redirect_to current_user, :alert => "Not authorized"
    end
  end

  def create
    if current_user.is? :moderator
      @user = User.new({ :email => params[:user][:email] })
      @user.roles = ["voter"]
      @user.password = rand(32**16).to_s(32)
      if @user.save
        UserMailer.send_login_invitation(@user).deliver
        redirect_to current_user, :notice => "An invitation has been emailed to #{ @user.email }"
      else
        render "new"
      end
    elsif current_user.is? :administrator
      # TODO
    else
      redirect_to current_user, :alert => "Not authorized"
      return
    end
  end
  
  def show
   @user = User.find_by_id(params[:id])
   #redirect_to current_user and return unless authorize(@user)
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    #redirect_to current_user and return unless authorize(@user)
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
      redirect_to current_user, :alert => "Not authorized"
    end
  end
  
  def destroy
  end

end
