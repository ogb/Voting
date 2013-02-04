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
    #VotingAlgorithms.new(:majority).winner(self.candidates)
   submissions = {}
    self.votes.each do |vote|
      if submissions[vote.candidate.title.to_sym]
        submissions[vote.candidate.title.to_sym] << vote
      else
        submissions[vote.candidate.title.to_sym] = [vote]
      end
    end
    return submissions.sort_by { |candidate, votes| votes.count }.last

  end
  
  def update_voters text_area
    # loop over lines in text area, check if user w/ that email exists
    # if not then create account + password and email that user
    # if yes then email that user with a link to the ballot
    # TODO
    logger.debug { "voter input: #{text_area}" }
    # lines split by "\r\n" ex: "Alec\r\nOliver"   
  
  
  end
  
  def update_candidates text_area
    logger.debug { "voter input: #{text_area}" }
  
    
  
  end
  
end

#TODO
# write email function on user model to email them, params = ballot id (if nil then email login link, else send ballot link)
# write the rest of the views
# run



