specialty = ['History', 'Food', 'Nightlife']

FactoryGirl.define do
  factory :specialty do |f|
    f.specialty { specialty.sample }
  end
end
