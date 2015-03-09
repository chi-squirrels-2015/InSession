require 'rails_helper'

feature 'User creates a new question' do
  given(:user) {User.create!(first_name: "sarah", last_name: "ing", email: Faker::Internet.email, password: "passwordchocolate")}

  scenario 'can click outside of form and hide it', js: true do
    visit '/'
    click_link("Login")
    within(".new_user") do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button("Login")
    end
    click_link("Ask a Question")
    page.execute_script('$(document.elementFromPoint(0, 0)).click();')
    expect(page).to have_no_content("Submit New Question")
  end

  scenario 'user can see preview of content', js: true do
    visit '/'
    click_link("Login")
    within(".new_user") do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button("Login")
    end
    click_link("Ask a Question")
    within("#new_question") do
      fill_in 'content', :with => 'New Fake Content'
    end
    click_button("Preview")
    expect(find('#preview-container')).to have_content("New Fake Content")
  end

  scenario 'user can see preview of markdown', js: true do
    visit '/'
    click_link("Login")
    within(".new_user") do
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button("Login")
    end
    click_link("Ask a Question")
    within("#new_question") do
      fill_in 'content', :with => "```ruby
def method
x = 2
end
```"
    end
    click_button("Preview")
    # require 'pry'; binding.pry
    expect(find("#preview-container")).to have_css(".CodeRay")
  end


end
