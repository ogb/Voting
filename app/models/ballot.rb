class Ballot < ActiveRecord::Base
  attr_accessible :algorithm, :description, :end_time, :title, :type
end
