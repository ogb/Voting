require "lib/VotingAlgorithms"

class Ballot < ActiveRecord::Base
  
  has_and_belongs_to_many :users
  has_many :candidates, dependent: :destroy
  has_many :votes, through: :candidates
  accepts_nested_attributes_for :candidates, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: false

  attr_accessible :algorithm, :description, :end_time, :title, :type, :public_results, :candidates_attributes
  
  validates :title, presence: true
  
  
  def winner
    VotingAlgorithms.new(:majority).winner(self.cadidates)
  end

end
