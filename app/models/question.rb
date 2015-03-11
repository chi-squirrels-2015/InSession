require 'elasticsearch/model'

class Question < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks	
  belongs_to :user
  belongs_to :course
  has_many :responses
  validates_presence_of :content, :title, :user_id

  self.per_page = 10
end

Question.import
