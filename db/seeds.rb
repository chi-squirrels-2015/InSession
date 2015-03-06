# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

User.create!(first_name:"sarah", last_name: "ing", email:"chocolate@gmail.com", password:"chocolate")


30.times do
  User.create!(first_name: Faker::Name.name, last_name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password, bio: "just want to learn", preferred_language: "english", street_address: Faker::Address.street_address, city: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

users = User.all

10.times do 
  Course.create!(name: Faker::Company.name, organization: Faker::Company.name, description: Faker::Commerce.product_name)
end

courses = Course.all

50.times do 
  Question.create!(title: Faker::Lorem.word, content: Faker::Lorem.sentence, user: users.sample, course: courses.sample)
end

questions = Question.all

75.times do
  Response.create!(content: Faker::Lorem.paragraph, user: users.sample, question: questions.sample )
end

responses = Response.all

10.times do 
  Venue.create!(name: Faker::Company.name, street_address: Faker::Address.street_address, city: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

venues = Venue.all

50.times do
  Meetup.create!(course: courses.sample, organizer: users.sample, venue: venues.sample, remote: true)
end

meetups = Meetup.all

50.times do
  CourseMembership.create!(course_id: courses.sample.id, user_id: users.sample.id)
end

50.times do
  MeetupMembership.create!(meetup_id: meetups.sample.id, user_id: users.sample.id)
end
