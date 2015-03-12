class Course < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :course_memberships
  has_many :users, through: :course_memberships
  has_many :questions
  has_many :course_meetups
  has_many :meetups, through: :course_meetups

  has_many :exercises
  belongs_to :subject
  validates :title, uniqueness: true
end
Course.import

