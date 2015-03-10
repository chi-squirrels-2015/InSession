class Course < ActiveRecord::Base
  has_many :course_memberships
  has_many :users, through: :course_memberships
  has_many :questions
  has_many :exercises
  belongs_to :subject
end
