require 'elasticsearch/model'
class UserExercise < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks	
    belongs_to :user
    belongs_to :exercise
end

UserExercise.import

