require "lib/VotingAlgorithms"

class Ballot < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates

  attr_accessible :algorithm, :description, :end_time, :title, :type, :public_results, :candidates_input, :voters_input
  
  validates :title, presence: true
  
  
  def winner
    VotingAlgorithms.new(:majority).winner(self.cadidates)
  end
  
  def update_voters text_area
    
  
  end
  
  def update_candidates text_area
    
  
  end

end
