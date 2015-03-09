# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# require 'faker'

User.create!(first_name:"Sarah", last_name: "Ing", email:"chocolate@gmail.com", password:"chocolate", street_address: "351 West Hubbard Street", city: "Chicago", state: "IL", zip: 60654, max_distance: 2)
User.create!(first_name:"Matthew", last_name: "Who", email:"matthewwho@me.com", password:"password", street_address: "351 West Hubbard Street", city: "Chicago", state: "IL", zip: 60654, max_distance: 2)
User.create!(first_name:"test", last_name: "test", email:"test@test.com", password:"password", street_address: "351 West Hubbard Street", city: "Chicago", state: "IL", zip: 60654, max_distance: 2)

# Added sleep 1 to keep Google happy
30.times do
  User.create!(first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email, password: "password", bio: "just want to learn", preferred_language: "english", street_address: Faker::Address.street_address, city: Faker::Address.city, zip: Faker::Address.zip_code)
  sleep 1
end

users = User.all

10.times do
  Course.create!(name: Faker::Company.name, organization: Faker::Company.name, description: Faker::Commerce.product_name)
end

courses = Course.all

150.times do 
  Question.create!(title: Faker::Hacker.say_something_smart, content: Faker::Hacker.say_something_smart, user: users.sample, course: courses.sample)
end

# 150.times do 
#   Question.create!(title: Faker::Hacker.say_something_smart, content: Faker::Hacker.say_something_smart, user: users.sample, course: courses.sample)
# end

array_of_question = ["How do I use css?",
"Can I use css for styling web pages",
"How does css work?",
"How can I create a straight “beveled” corner (or two) with an outline using CSS?",
"How to add a element between two elements in HTML with css",
"What is css?",
"Where does css come from?",
"How do you change margins with css?",
"How do you change the background in css?",
"How do I fix font size in css?",
"How do I learn css?",
"Can I use css in rails?",
"Why is my background not showing up with css?",
"How do I bold my font with css?",
"What is css used for?",
"Can I use css to change an image?",
"Can I use css in html?",
"Why is css used for styling?",
"Where can I find good css tutorials?",
"How do I center text with css?",
"How do I center elements with css?",
"How do I change the position of an element with css?",
"How do I change the background color with css?",
"How do I change the navbar position with css?",
"How do I create a dotted border line with css?",
"How do I create a dashed border line with css?",
"UNRELATED: Can SASS be used to style a webpage",
"UNRELATED: What is the answer to life, the universe, and everything?",
"UNRELATED: How can I use Meteor to build a beautiful website?",
"UNRELATED: Can you tell me how to get to Sesame Street.com on the web?",
"UNRELATED: What is a banana?",
"UNRELATED: Where is the best place to get ingredients?",
"UNRELATED: Where should I schedule my dinner on Friday?",
"UNRELATED: How do I learn to dougie?",
"UNRELATED: When will Duke Jokes be back?",
"UNRELATED: When will DBC buy me an Airwheel?",
"UNRELATED: How is cheese made?",
"UNRELATED: What is the real story behind Cinco de Mayo?",
"UNRELATED: When will DBC's website be rebuilt with Meteor?"]
39.times do 
	Question.create!(title: array_of_question.pop, content: Faker::Hacker.say_something_smart, user: users.sample, course: courses.sample)

end	
questions = Question.all

75.times do
  Response.create!(content: Faker::Lorem.paragraph, user: users.sample, question: questions.sample )
end

responses = Response.all

# response = HTTParty.get("https://data.cityofchicago.org/resource/wa2i-tm5d.json")
# p venues = JSON.parse(response.body)

venues_array = SmarterCSV.process('db/Libraries.csv', row_sep: "\r")

venues_array.each do |venue|
  Venue.create!(venue)
end



50.times do
  venue = Venue.find(rand(Venue.count)+1)
  Meetup.create!(course: courses.sample, organizer: users.sample, venue: venue, remote: true, latitude: venue.latitude, longitude: venue.longitude)
end

meetups = Meetup.all

50.times do
  CourseMembership.create!(course_id: courses.sample.id, user_id: users.sample.id)
end

50.times do
  MeetupMembership.create!(meetup_id: meetups.sample.id, user_id: users.sample.id)
end

ka = Provider.create!(name: "khan_academy",
                      site: "http://www.khanacademy.org/api/v1",
                      key: "UHze9rM6n5NtNee2",
                      secret: "f9Z24DkmGTyWZx5E")

users.each do |user|
  number = rand(1000..9999).to_s
  Authorization.create!(provider: Provider.find(ka.id),
                        uid: "uidstring" + number,
                        user: user,
                        user_token: "user_token" + number,
                        user_secret: "user_secret" + number)
end


# def struggle
#   if parsed_response.exercise_states["struggling"] = true
#   end
# end
