require "lib/VotingAlgorithms"

class Ballot < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates
  # this is ugly... but it avoids nested models in nested forms. we don't have time for that on the first iteration

  attr_accessible :algorithm, :description, :end_time, :title, :type, :public_results
  
  validates :title, presence: true
  
  
  def winner
    VotingAlgorithms.new(:majority).winner(self.cadidates)
  end
  
  def update_voters text_area
    # loop over lines in text area, check if user w/ that email exists
    # if not then create account + password and email that user
    # if yes then email that user with a link to the ballot
    # TODO
  
  
  end
  
  def update_candidates text_area
    
  
    
  
  end
  
  def vote candidate
    # create new vote for candidate from current user and save it
  
  end

end

#TODO
# add fields to views (mod and voter)
# write email function on user model to email them, params = ballot id (if nil then email login link, else send ballot link)
# write update functions
# write the rest of the views
# write voting algorithms
# run



