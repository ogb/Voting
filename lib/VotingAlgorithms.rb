
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
    # TODO
  
  end


end


