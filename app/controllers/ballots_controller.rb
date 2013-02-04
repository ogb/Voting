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
    @ballot.votes.each { |v| redirect_to @ballot notice: "You have already voted on this ballot." if current_user.votes.include?(v) }
  end
  
  def update
    # update ballot data, send back to show page
    if current_user.is? "moderator"
      # update info for the ballot
      @ballot = Ballot.find_by_id(params[:id])
      @ballot.update_voters(params[:voters_input])
      @ballot.update_candidates(params[:candidates_input])
      if @ballot.update_attributes(filter_params(params))
        redirect_to @ballot, notice: "Updated ballot"
      else
        render "edit"
      end
    elsif current_user.is? "voter"
      # find selected candidate and create new vote model for it
      candidate = Candidate.find(params[:candidates][:selected])
      redirect_to @ballot, alert: "Could not find candidate" if candidate.nil?
      vote = Vote.new({ :value => 1 })
      vote.user = current_user
      vote.candidate = candidate
      if vote.save
        candidate.votes << vote
        current_user.votes << vote
        candidate.save
        current_user.save
        redirect_to @ballot, notice: "Vote Saved"
      else
        redirect_to @ballot, alert: "Could not save vote"
      end
    end
  end
  
  def destroy
    # delete record, send to show page
    @ballot = Ballot.find_by_id(params[:id])
    
    
  end

end
