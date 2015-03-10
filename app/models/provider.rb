class Provider < ActiveRecord::Base
  has_many :authorizations
  has_many :users, through: :authorizations
  has_many :providers_subjects
  has_many :courses, through: :providers_subjects
  has_many :exercises, through: :courses
end
