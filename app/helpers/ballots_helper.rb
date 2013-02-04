module BallotsHelper


  def filter_params params
    # TODO filter relevant params that should be editable
    { :id => params[:id], :title => params[:title], :description => params[:description], 
    :end_time => params[:end_time], :public_results => params[:public_results] }
  end
  
  def majority votes
    submissions = {}
    votes.each do |vote|
      if submissions[vote.candidate.title.to_sym]
        submissions[vote.candidate.title.to_sym] << vote
      else
        submissions[vote.candidate.title.to_sym] = [vote]
      end
    end
    return submissions.sort_by { |candidate, votes| votes.count }
  end

end
