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
                   phone: '3127592048', age: 25, tagline: "It's gonna be a good time.",
                   is_ambassador: true)

gender = ['male','female']
boolean = [true,false]

50.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, 
               email: Faker::Internet.email, profile_pic: 'pic', bio: Faker::Lorem.sentences.join(" "), 
               gender: gender.sample, phone: Faker::PhoneNumber.cell_phone, age: (18..60).to_a.sample, 
               tagline: Faker::Commerce.product_name, is_ambassador: boolean.sample)
end

user.users_specialties.create(specialty_id:1)
user.users_specialties.create(specialty_id:2)
user.languages_spoken.create(language_id:1)

200.times do
  user = User.find((1..51).to_a.sample)
  user.tours.create!(longitude: Faker::Address.longitude,
                     latitude: Faker::Address.latitude,
                     description: Faker::Lorem.paragraphs.join("\n\n"))
end