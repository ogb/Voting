
class VotingAlgorithms

  def initialize type
    @type = type
  end

  def winner votes
    case @type
      when :majority then majority(votes)
      # when :least_majority then least_majority votes
    end
  end
  
  private
  
  def majority votes
    submissions = {}
    votes.each do |vote|
      if submissions[vote.candidate.title.to_sym]
        submissions[vote.candidate.title.to_sym] << vote
      else
        submissions[vote.candidate.title.to_sym] = [vote]
      end
    end
    return submissions.sort_by { |candidate, votes| votes.count }.last
  end
  
end


