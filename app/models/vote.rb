class Vote < ActiveRecord::Base
 
  belongs_to :candidate
  belongs_to :user

  attr_accessible :value, :updated_at

  validates :candidate_id, presence: true
  validates :user_id, presence: true


end
