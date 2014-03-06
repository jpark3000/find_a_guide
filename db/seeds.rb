require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

s1 = Specialty.create!(specialty: "Culture")
s2 = Specialty.create!(specialty: "Nightlife")
s3 = Specialty.create!(specialty: "Food and Drink")

# Specialty.create!(specialty: "Special Events")
# Specialty.create!(specialty: "Art"
# Specialty.create!(specialty: "Adventure")
# Specialty.create!(specialty: "Navigator")
# Specialty.create!(specialty: "Music")

l1 = Language.create!(language: "English")
l2 = Language.create!(language: "Spainish")
l3 = Language.create!(language: "Korean")
l4 = Language.create!(language: "German")

gender = ['male','female']
boolean = [true,false]

random_uid = ['511571783', '724578054', '1037742890', '100000287146443', '100001318974142', '1632193255', '568774194', '100002092401128', '100001847404308', '812240594', '756515675', '739760365', '205400447', '100000615675453', '661644102', '6025069', '667347118', '205400014', '775530383', '205400045', '645635108', '100001708508222', '205400469', '1211270', '205400552', '763415440', '205400767', '100000200855790', '692761059', '13309604']

50.times do
  User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
               email: Faker::Internet.email, bio: Faker::Lorem.sentences.join(" "),
               gender: gender.sample, phone: Faker::PhoneNumber.cell_phone, age: (18..60).to_a.sample,
               tagline: Faker::Commerce.product_name, is_ambassador: true, uid: random_uid.sample, profile_pic: "http://graph.facebook.com/#{random_uid.sample}/picture?type=large").save(validate: false)
end

user = User.first

user.is_ambassador = true
user.ambassador_availability = true
user.save
user.users_specialties.create(specialty_id:1)
user.users_specialties.create(specialty_id:2)
user.languages_spoken.create(language_id:1)

200.times do
  user = User.find((1..50).to_a.sample)
  if user.is_ambassador
    user.tours.create!(longitude: Faker::Address.longitude,
                       latitude: Faker::Address.latitude,
                       description: Faker::Lorem.paragraphs.join("\n\n"))
  end
end

ambassadors_ids = User.where('is_ambassador = ?', true).map{|u| u.id}

User.all.each do |u|
  10.times do
    ambassador_id = (ambassadors_ids - [u.id]).sample
    meetup = u.visitor_meetups.create!(ambassador_id: ambassador_id,
                                       tour_id: (rand(200)+1),
                                       date_time: [rand(2.months).ago, rand(2.months).from_now].sample,
                                       address: Faker::Address.street_address,
                                       meetup_notes: Faker::Lorem.sentences.join(" "))
    if ambassador_id == 1
      if Time.now - meetup.date_time > 7.days
        meetup.reviews.create!(reviewee_id: 1, reviewer_id: u.id,
                               comment: Faker::Company.bs, rating: (1..5).to_a.sample )
      end
    end
  end
end

# Real person seed data

# real_person_uid = ['511571783', '724578054', '1037742890', '100000287146443', '100001318974142', '1632193255', '568774194', '100002092401128', '100001847404308', '812240594', '756515675', '739760365', '205400447', '100000615675453', '661644102', '6025069', '667347118', '205400014', '775530383', '205400045', '645635108', '100001708508222', '205400469', '1211270', '205400552', '763415440', '205400767', '100000200855790', '692761059', '13309604']


# real_person_uid.each do |uid|
#   User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
#                email: Faker::Internet.email, bio: Faker::Lorem.sentences.join(" "),
#                gender: gender.sample, phone: Faker::PhoneNumber.cell_phone, age: (18..60).to_a.sample,
#                tagline: Faker::Commerce.product_name, is_ambassador: true, uid: uid, profile_pic: "http://graph.facebook.com/#{uid}/picture?type=large").save(validate: false)
# end

# 250.times do
#     User.all.sample.tours.create!(longitude: Faker::Address.longitude,
#                        latitude: Faker::Address.latitude,
#                        description: Faker::Lorem.paragraphs.join("\n\n"))
# end


