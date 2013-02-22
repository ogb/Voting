class Vote < ActiveRecord::Base
 
  belongs_to :candidate
  belongs_to :user
  belongs_to :ballot

  attr_accessible :value, :candidate, :user
  
end
