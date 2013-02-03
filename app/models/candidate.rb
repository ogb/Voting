class Candidate < ActiveRecord::Base
  
  belongs_to :ballot
  has_many :votes, dependent: :destroy

  attr_accessible :description, :title

  validates :ballot_id, presence: true



end
