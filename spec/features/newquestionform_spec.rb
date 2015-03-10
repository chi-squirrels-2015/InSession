require 'rails_helper'

feature 'User creates a new question' do
  given!(:user) {User.create!(first_name: "sarah", last_name: "ing", email: "chocolate@gmail.com", password: "passwordchocolate")}
  given!(:question) {Question.create!(title: "here", content: "super", user: user)}

  scenario 'can click new question button and fill out form', js: true do
    visit '/users/sign_in'
    within(".content-wrapper #new_user") do
      fill_in 'Email', :with => "chocolate@gmail.com"
      fill_in 'Password', :with => "passwordchocolate"
    end
    click_button("Log in")


    visit '/questions'
    click_link("Ask a Question")

    within("#new_question") do
      fill_in 'title', :with => "title of question"
      fill_in 'content', :with => "content of question"
      click_button("Submit New Question")
    end

    expect(page).to have_content("content of question")
  end
end
