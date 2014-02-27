require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

s1 = Specialty.create!(specialty: "History")
s2 = Specialty.create!(specialty: "Nightlife")
s3 = Specialty.create!(specialty: "Food")

l1 = Language.create!(language: "English")
l2 = Language.create!(language: "Spainish")
l3 = Language.create!(language: "Korean")
l4 = Language.create!(language: "German")

user = User.create!(first_name: "user", last_name: 'user', email: 'email@email.com',
                   profile_pic: 'pic', bio: 'this is my bio', gender: 'male',
                   phone: '3127592048', age: 25, tagline: "It's gonna be a good time.")
User.create!(first_name: "bob", last_name: 'smith', email: 'bob@email.com',
             profile_pic: 'pic', bio: "this is bob's bio", gender: 'male',
             phone: '3127592048', age: 25, tagline: "It's gonna be an awesome time.")
User.create!(first_name: "fill", last_name: 'park', email: 'jill@email.com',
             profile_pic: 'pic', bio: "this is jill's bio", gender: 'female',
             phone: '3127592048', age: 25, tagline: "It's gonna be an excellent time.")

user.users_specialties.create(specialty_id:1)
user.users_specialties.create(specialty_id:2)
user.languages_spoken.create(language_id:1)

user.tours.create!(longitude: Faker::Address.longitude,
                  latitude: Faker::Address.latitude,
                  description: Faker::Lorem.paragraphs.join("\n\n"))
user.tours.create!(longitude: '41.8819',
                  latitude: '87.6278',
                  description: Faker::Lorem.paragraphs.join("\n\n"))
user.tours.create!(longitude: '41.8819',
                  latitude: '87.6278',
                  description: Faker::Lorem.paragraphs.join("\n\n"))
user.tours.create!(longitude: '41.8819',
                  latitude: '87.6278',
                  description: Faker::Lorem.paragraphs.join("\n\n"))
user.tours.create!(longitude: '41.8819',
                  latitude: '87.6278',
                  description: Faker::Lorem.paragraphs.join("\n\n"))

