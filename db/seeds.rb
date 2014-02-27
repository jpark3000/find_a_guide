require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(first_name: "user", last_name: 'user', email: 'email@email.com',
                   profile_pic: 'pic', bio: 'this is my bio', gender: 'male',
                   phone: '3127592048', age: 25)
User.create!(first_name: "bob", last_name: 'smith', email: 'bob@email.com',
             profile_pic: 'pic', bio: "this is bob's bio", gender: 'male',
             phone: '3127592048', age: 25)
User.create!(first_name: "fill", last_name: 'park', email: 'jill@email.com',
             profile_pic: 'pic', bio: "this is jill's bio", gender: 'female',
             phone: '3127592048', age: 25)

Specialty.create!(specialty: "History")
Specialty.create!(specialty: "Nightlife")
Specialty.create!(specialty: "Food")

Language.create!(language: "English")
Language.create!(language: "Spainish")
Language.create!(language: "Korean")
Language.create!(language: "German")


  # user.tours.create!(longitude: Faker::Address.longitude,
  #                   latitude: Faker::Address.latitude,
  #                   description: Faker::Lorem.sentences)
user.tours.create!(longitude: '41.8819',
                  latitude: '87.6278',
                  description: 'Chicago tour (not for the faint of heart)')

