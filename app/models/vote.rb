class Vote < ActiveRecord::Base
 
  belongs_to :candidate
  belongs_to :user

  attr_accessible :value

  validates :candidate_id, presence: true
  validates :user_id, presence: true


end
