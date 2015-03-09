require 'rails_helper'

feature 'User creates a new question' do
  given(:user) {User.create!(first_name: "sarah", last_name: "ing", email: Faker::Internet.email, password: "passwordchocolate")}

  scenario 'can click new question button and fill out form', js: true do
    visit '/questions'
    click_link("Ask a Question")
   
    within(".question_title") do
      fill_in 'title', :with => "title of question"
      fill_in 'content', :with => "content of question"
      click_button("Submit New Question")
    end
    click_link("Ask a Question")
    page.execute_script('$(document.elementFromPoint(0, 0)).click();')
    expect(page).to have_no_content("Submit New Question")
  end

 


end
