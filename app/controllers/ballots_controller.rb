class BallotsController < ApplicationController

  before_filter :check_session, only: [:index, :show, :edit, :new]

  def index
    @ballots = current_user.ballots
  end
  
  def show
    @ballot = Ballot.find_by_id(params[:id])
    redirect_to current_user unless authorize(@ballot)

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
    redirect_to current_user unless authorize(@ballot)
    
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
