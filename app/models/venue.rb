class Venue < ActiveRecord::Base
  has_many :meetups 
  
end
