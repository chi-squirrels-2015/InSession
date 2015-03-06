# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

User.create!(username:"sarah", email:"sarahikeda@gmail.com", password:"password")


10.times do
  User.create!(first_name: Faker::Name.name, last_name: Faker::Name.name, username: Faker::Name.name, email: Faker::Internet.email, password: "password", bio: "just want to learn", preferred_language: "english")
end

users = User.all

