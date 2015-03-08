require 'elasticsearch/model'
class Meetup < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks	
  belongs_to :course
  belongs_to :venue
  belongs_to :organizer, class_name: "User"
  has_many :meetup_memberships
  has_many :course_meetups
  has_many :users, through: :meetup_memberships
  has_many :courses, through: :course_meetups 
end

Meetup.import


