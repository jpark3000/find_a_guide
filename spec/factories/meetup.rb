require 'faker'

FactoryGirl.define do
  factory :meetup do |f|

    f.ambassador_id { 1 }
    f.tour_id { rand(200)+1 }
    f.date_time { [rand(2.months).ago, rand(2.months).from_now].sample }
    f.address { Faker::Address.street_address }
    f.meetup_notes { Faker::Lorem.sentences.join(" ") }

  end
end
