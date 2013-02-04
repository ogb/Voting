#require "lib/VotingAlgorithms"

class Ballot < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates
  # this is ugly... but it avoids nested models in nested forms. we don't have time for that on the first iteration

  attr_accessible :algorithm, :description, :end_time, :title, :type, :public_results, :voter_input, :candidate_input

  attr_accessor :voter_input, :candidate_input	
  
  validates :title, presence: true
  
  
  def winner
    majority(self.votes).last
  end
  
  def update_voters text_area
    text_area.split("\r\n").each do |email|
      next if email.blank? or email.nil?
      return false unless email.match /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      user = User.find_by_email(email)
      if user
        self.users << user
        UserMailer.send_vote_invitation(user, self).deliver
      else
        pass = rand(36**10).to_s(36)
        user = User.new({ :email => email, :password => pass })
        UserMailer.send_login_invitation(user).deliver
      end
    end
    self.save
  end
  
  def update_candidates text_area
    text_area.split("\r\n").each do |title|
      next if title.blank? or title.nil?
      candidate = Candidate.find_by_title(title)
      unless candidate
        candidate = Candidate.new({ :title => title })
        candidate.ballot = self
        self.candidates << candidate
        candidate.save
      end
    end
    self.save
  end
  
end



