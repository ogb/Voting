class ApplicationController < ActionController::Base
  protect_from_forgery



  
  
  def authorize obj = nil
    if obj.class == "Ballot"
      if !current_user.ballots.include?(obj)
        return false
      else
      current_user.ballots.each do |ballot|
        unless ballot.users.include?(current_user)
          return false
        end
      end
    end
    elsif obj.class == "User"
      return false unless current_user.is? "moderator"
    else
      # nothing TODO throw an error
    end
    return true
  end
  
  def check_session
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
    
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
end
