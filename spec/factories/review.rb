require 'faker'

FactoryGirl.define do
  factory :review do |f|

    f.meetup_id { 1 }
    f.reviewee_id { 1 }
    f.reviewer_id { 1 }
    f.comment { Faker::Company.bs }
    f.rating { (1..5).to_a.sample }

  end
end

