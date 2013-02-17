class Vote < ActiveRecord::Base
 
  belongs_to :candidate
  belongs_to :user

  attr_accessible :value, :candidate, :user
  
end
