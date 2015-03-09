require 'rails_helper'

describe Question do
  let(:question) { Question.new }

  describe "validations" do
    it "is invalid when there is no content" do
      question.content = nil
      question.valid?
      expect(question.errors[:content]).to_not be_empty
    end

    it "is invalid when there is no title" do
      question.title = nil
      question.valid?
      expect(question.errors[:title]).to_not be_empty
    end

    it "is made when there is a user attached to the question" do
       new_user = User.create(first_name: "sarah", last_name: "ing", email: "sarah@gmail.com", password: "password")
      question.user = new_user
      question.valid?
      expect(question.errors[:user_id]).to be_empty
    end

  end


end
