class Course < ActiveRecord::Base
  has_many :course_memberships
  has_many :users, through: :course_memberships
  has_many :questions
end
