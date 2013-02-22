class VotesController < ApplicationController

  before_filter :check_session, only: [:index]

  def index
    if current_user.is? :voter
    	@votes = current_user.votes
    elsif current_user.is? :moderator
    	@votes = []
    	current_user.ballots.each { |b| b.votes.each { |v| @votes << v } } # do this to avoid returning an activerecord::relation object
    	@votes.sort_by! { |v| v.candidate.title }
    elsif current_user.is? :administrator
    	@votes = Vote.all
    end
  end
  

end
