class Exercise < ActiveRecord::Base
  has_many :user_exercises
  has_many :users, through: :user_exercises
  belongs_to :course
  validates :title, presence: true
end
