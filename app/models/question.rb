class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  validates_presence_of :content, :title, :user_id
end
