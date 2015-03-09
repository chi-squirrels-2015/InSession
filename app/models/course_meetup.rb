class CourseMeetup < ActiveRecord::Base
  belongs_to :meetup
  belongs_to :course
end
