class BallotsController < ApplicationController

  # TODO add all functions to the array
  before_filter :authorize, only: [:index, :show, :update]

  def index
    # send to page to show all ballots TODO
    # if moderator, show all ballots for ballots created
    # if voter, show all ballots that user has submitted
    # if admin, show all ballots for everybody
    
  end
  
  def show
    @ballot = Ballot.find_by_id(params[:id])
    # render a page with a single ballot on it
    
  end
  
  def new
    # send to page to create new ballot
    
    
  end
  
  def create
    # actually create a new ballot
    
  end
  
  def edit
    # send to page to edit ballots
    @ballot = Ballot.find_by_id(params[:id])
    
    
  end
  
  def update
    # update ballot data, send back to show page
    @ballot = Ballot.find_by_id(params[:id])

    
  end
  
  def destroy
    # delete record, send to show page
    @ballot = Ballot.find_by_id(params[:id])

    
    
  end

end
