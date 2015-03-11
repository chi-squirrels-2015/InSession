class Exercise < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks	
  has_many :user_exercises
  has_many :users, through: :user_exercises
  validates :title, presence: true
end

Exercise.import