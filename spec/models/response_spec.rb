require 'rails_helper'

describe Response do
  let(:response) { Response.new }
  let(:new_user) { User.create(first_name: "sarah", last_name: "ing", email: "sarah@gmail.com", password: "password") }

  describe "validations" do
    it "is invalid when there is no content" do
      response.content = nil
      response.valid?
      expect(response.errors[:content]).to_not be_empty
    end

    it "valid when there is a question attached to the response" do
      new_question = Question.create!(title: "hello", content: "Super awesome", user: new_user)
      response.question = new_question
      response.valid?
      expect(response.errors[:question_id]).to be_empty
    end

    it "is made when there is a user attached to the question" do
      response.user = new_user
      response.valid?
      expect(response.errors[:user_id]).to be_empty
    end 
  end


end
