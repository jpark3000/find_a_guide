require 'faker'

FactoryGirl.define do
  factory :tour do |f|

    f.longitude { Faker::Address.longitude }
    f.latitude { Faker::Address.latitude }
    f.description { Faker::Lorem.paragraphs.join("\n\n") }

  end
end
