class ApplicationController < ActionController::Base
  protect_from_forgery

  
  def authorize obj = nil
    logger.debug obj.class.to_s
    if obj.class.to_s == "Ballot"
      if current_user.is? "voter"
        return false unless obj.users.include? current_user
      elsif current_user.is? "moderator"
        return false unless current_user.ballots.include? obj
      end
    elsif obj.class.to_s == "User"
      return false unless current_user.is? "moderator" or current_user == obj
    else
      logger.debug { "error authorizing: #{ obj.to_json }" }
      return false
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
    
  def valid_email_regex
    /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  end
  helper_method :valid_email_regex
  
end
