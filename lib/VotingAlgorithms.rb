
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
    submissions = Hash.new
    votes.each do |vote|
      if submissions.keys.include? vote.title
        submissions[ vote.title.to_sym ] += 1;
      else
        submissions[ vote.title.to_sym ] = 1;
      end # if
    end # each
    return submissions.sort_by { |key, value| value }
  end # majority(votes)
  
end


