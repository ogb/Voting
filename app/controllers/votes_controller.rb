class VotesController < ApplicationController

  before_filter :authorize, only: [:index]

  def index
    # if moderator, show all votes for ballots created
    # if voter, show all votes that user has submitted
    # if admin, show all votes for everybody
    
  end
  

end
