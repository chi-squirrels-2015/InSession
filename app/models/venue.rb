class Venue < ActiveRecord::Base
  extend ::Geocoder::Model::ActiveRecord
  has_many :meetups
  has_many :courses, through: :meetups

  geocoded_by :full_street_address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates

end
