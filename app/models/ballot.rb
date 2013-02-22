class Ballot < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates
  accepts_nested_attributes_for :candidates, allow_destroy: true

  attr_accessible :algorithm, :description, :end_time, :title, :type, :public_results, :candidates_attributes, :user_ids, :_destroy

  attr_accessor :_destroy
    
  validates :title, presence: true

  # returns a sorted list of candidates by the ballot's stored algorithm option
  def winners
    case self.algorithm
    when "majority" then majority
    # and so on...
    else
      majority
    end
  end

  def winner
    winners.first
  end

  def active?
    !self.end_time.nil? and !self.end_time.past?
  end

  def cast_vote user, candidate
    vote = Vote.new
    vote.user = user
    vote.candidate = candidate
    if vote.save
      candidate.votes << vote
      user.votes << vote
      candidate.save
      user.save
      return true
    else
      return false
    end
  end

  private

  def majority
    self.candidates.sort_by { |c| c.votes.count }.reverse
  end

  # and so on...
  
end



