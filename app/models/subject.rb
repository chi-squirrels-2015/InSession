class Subject < ActiveRecord::Base
  has_many :courses
  has_many :examples, through: :courses
  belongs_to :providers_subjects
end
