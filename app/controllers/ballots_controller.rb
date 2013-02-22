class BallotsController < ApplicationController

  before_filter :check_session, only: [ :index, :show, :edit, :new ]

  def index
    if current_user.is? :moderator
      @ballots = current_user.ballots
    elsif current_user.is? :voter
      @ballots = []
      Ballot.all.each do |ballot|
        @ballots << ballot if ballot.users.include?(current_user)
      end
      redirect_to current_user, notice: "No available ballots" if @ballots.count.zero?
    else
      @ballots = Ballot.all
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
      current_user.ballots << @ballot
      current_user.save
      redirect_to @ballot
    else
      render "new"
    end
  end
  
  def edit
    @ballot = Ballot.find_by_id(params[:id])
    redirect_to current_user, :alert => "Not Authorized" unless authorize(@ballot)
  end
  
  def update
    # update ballot data, send back to show page
    @ballot = Ballot.find_by_id(params[:id])
    if current_user.is? "moderator"
      # update info for the ballot
      logger.debug params.inspect
      if params[:ballot][:_destroy] == "1"
        redirect_to :controller => :ballots, :action => :index and return if @ballot.nil?
        @ballot.destroy
        redirect_to :controller => :ballots, :action => :index, :notice => "Deleted ballot"
        return
      end
      # TODO add the email functionality to email them that they have been added to a ballot


      if @ballot.update_attributes(params[:ballot])
        unless current_user.ballots.include? @ballot # hack to fix simpleform's association issue
          current_user.ballots << @ballot
          current_user.save
        end
        redirect_to @ballot, notice: "Updated ballot"
      else
        render "edit"
      end
    elsif current_user.is? "voter"
      redirect_to @ballot, alert: "You have already voted on this ballot." and return if current_user.voted_on? @ballot
      candidate = Candidate.find_by_id(params[:ballot][:candidate_ids])
      if @ballot.cast_vote current_user, candidate
        redirect_to :controller => :ballots, :action => :index, notice: "Vote Saved"
      else
        redirect_to @ballot, alert: "Could not save vote"
      end
    end
  end
  
  def destroy
    @ballot = Ballot.find_by_id(params[:id])
    if current_user.ballots.include? @ballot
      @ballot.destroy
      redirect_to current_user, :notice => "Deleted ballot"
    else
      redirect_to current_user, :alert => "Not authorized to delete ballot"
    end
  end

end
