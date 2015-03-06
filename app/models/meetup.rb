class Meetup < ActiveRecord::Base
  belongs_to :course
  belongs_to :venue
  belongs_to :organizer, class_name: "User"
  has_many :meetup_memberships
  has_many :users, through: :meetup_memberships
end
