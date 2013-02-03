class UsersController < ApplicationController
  
  before_filter :authorize, only: [:index, :show, :edit]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to :controller => "user", :action => "show", :id => @user.id
    else
      render "new"
    end
  end
  
  def show
   @user = User.find_by_id(params[:id])
  end
  
  def edit
    @user = User.find_by_id(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to :controller => "user", :action => "show", :id => @user.id
    else
      render "edit"
    end
  end
  
  def index
    if current_user.is? "administrator"
      @users = User.all
      render "index"
    else
      flash.now[:error] = "Not authorized"
    end
  end

  # TODO implement delete/destroy when admins are set up

end
