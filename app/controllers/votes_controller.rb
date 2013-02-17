class VotesController < ApplicationController

  before_filter :check_session, only: [:index]

  def index
    # if moderator, show all votes for ballots created
    # if voter, show all votes that user has submitted
    # if admin, show all votes for everybody
      @votes = current_user.votes
  end
  

end
