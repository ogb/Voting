class VotesController < ApplicationController

  # TODO add all functions to the array
  before_filter :authorize, only: [:index]





  def index
    # send to page to show all votes TODO
    # if moderator, show all votes for ballots created
    # if voter, show all votes that user has submitted
    # if admin, show all votes for everybody
    
  end
  

end
