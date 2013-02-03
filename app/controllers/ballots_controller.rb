class BallotsController < ApplicationController

  # TODO add all functions to the array
  before_filter :authorize, only: [:index, :show, :edit]

  def index
    @ballots = current_user.ballots
  end
  
  def show
    @ballot = Ballot.find_by_id(params[:id])
  end
  
  def new
    # send to page to create new ballot
    @ballot = Ballot.new
  end
  
  def create
    # actually create a new ballot
    @ballot = Ballot.new(params[:ballot])   
    
    
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
