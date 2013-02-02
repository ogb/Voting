
require "lib/VotingAlgorithms"

class Ballot < ActiveRecord::Base
  
  belongs_to :user
  has_many :votes

  attr_accessible :algorithm, :description, :end_time, :title, :type
  
  
  
  
  
  def winner
    VotingAlgorithms.new(:majority).winner(self.votes)
  end

end
