class Vote < ActiveRecord::Base
  
  belongs_to :ballot
  has_many :users

  attr_accessible :title, :value
  
  
  
  
  

end
