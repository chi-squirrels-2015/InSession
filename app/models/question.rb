class Question < ActiveRecord::Base
  belongs_to :user
   validates_presence_of :content, :title, :user_id
end
