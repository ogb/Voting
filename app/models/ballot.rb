class Ballot < ActiveRecord::Base
  
  belongs_to :user
  has_many :votes

  attr_accessible :algorithm, :description, :end_time, :title, :type


end
