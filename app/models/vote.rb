class Vote < ActiveRecord::Base
  
  belongs_to :ballot
  has_and_belongs_to_many :users

  attr_accessible :title, :value
  

end
