class VotesController < ApplicationController

  # TODO add all functions to the array
  before_filter :authorize, only: [:index, :show, :update]





  def index
    # send to page to show all votes TODO
    # if moderator, show all votes for ballots created
    # if voter, show all votes that user has submitted
    # if admin, show all votes for everybody
    
  end
  
  def show
    @vote = Vote.find_by_id(params[:id])
    # render a page with a single vote on it
    
  end
  
  def new
    # send to page to create new vote
    
    
  end
  
  def create
    # actually create a new vote
    
  end
  
  def edit
    # send to page to edit votes
    @vote = Vote.find_by_id(params[:id])
    
    
  end
  
  def update
    # update vote data, send back to show page
    @vote = Vote.find_by_id(params[:id])

    
  end
  
  def destroy
    # delete record, send to show page
    @vote = Vote.find_by_id(params[:id])

    
    
  end

end
