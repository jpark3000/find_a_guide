require 'faker'

gender = ['m', 'f']
FactoryGirl.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    sequence(:email) { |number| "user#{number}@blah.com" }


    f.uid { rand(1..10000000) }

    f.phone { Faker::PhoneNumber.phone_number }
    f.username { Faker::Internet.user_name }

    f.provider { 'facebook' }
    f.gender { gender.sample }
    f.age { rand(1..100) }
    f.bio { Faker::Company.bs }
    f.tagline { Faker::Company.catch_phrase }
    f.oauth_token { Faker::Number.number(25) }
    f.oauth_expires_at { "2000-01-01 21:00:00"}
  end
end
