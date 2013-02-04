class UserMailer < ActionMailer::Base
  default from: "ajembke345@gmail.com"
  
  def send_vote_invitation user, ballot
    @user = user
    @ballot = ballot
    mail to: user.email, subject: "You're invited to vote on a ballot"
  end
  
  def send_login_invitation user
    @user = user
    mail to: user.email, subject: "You're invited to create an account"
  end
  
end
