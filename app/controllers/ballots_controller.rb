class BallotsController < ApplicationController

  before_filter :check_session, only: [:index, :show, :edit, :new]

  def index
    if current_user.is? "moderator"
      @ballots = current_user.ballots
    elsif current_user.is? "voter"
      @ballots = []
      Ballot.all.each do |ballot|
        @ballots << ballot if ballot.users.include?(current_user)
      end
    else
      # TODO admin
    end
  end
  
  def show
    @ballot = Ballot.find_by_id(params[:id])
    redirect_to current_user unless authorize(@ballot)
  end
  
  def new
    # send to page to create new ballot
    redirect_to current_user unless current_user.is? "moderator"
    @ballot = Ballot.new
  end
  
  def create
    # actually create a new ballot
    @ballot = current_user.ballots.build(params[:ballot]) 
    if @ballot.save
      redirect_to @ballot
    else
      render "new"
    end
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
  
  def add_voters
    
  
  
  end
  
  def add_candidates
  
  
  
  end

end
