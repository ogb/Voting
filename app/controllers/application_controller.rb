class ApplicationController < ActionController::Base
  protect_from_forgery



  
  
  def authorize obj = nil
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
    # TODO write check for user rlationships, should only allow mods to see voters
    flash.now[:notice] = "Not Authorized" unless obj.nil? or current_user.ballots.include?(obj)
  end
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
end
