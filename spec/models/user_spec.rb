require_relative '../spec_helper'

describe User do
  #Association Testing
  it { should have_many(:users_specialties) }
  it { should have_many(:specialties).through(:users_specialties) }

  it { should have_many(:languages_spoken) }
  it { should have_many(:languages).through(:languages_spoken) }

  it { should have_many(:visitor_reviews).through(:visitor_meetups).source(:reviews) }
  it { should have_many(:ambassador_reviews).through(:ambassador_meetups).source(:reviews) }

  it { should have_many(:reviews_given).class_name('Review') }
  it { should have_many(:reviews_given).with_foreign_key('reviewer_id') }
  it { should have_many(:reviews_received).class_name('Review') }
  it { should have_many(:reviews_received).with_foreign_key('reviewee_id') }

  it { should have_many(:tours).class_name('Tour') }
  it { should have_many(:tours).with_foreign_key('ambassador_id') }

  it { should have_many(:ambassador_meetups).class_name('Meetup') }
  it { should have_many(:ambassador_meetups).with_foreign_key('ambassador_id') }
  it { should have_many(:visitor_meetups).class_name('Meetup') }
  it { should have_many(:visitor_meetups).with_foreign_key('visitor_id') }

  # Validation Testing
  it {should validate_presence_of :first_name}
  it {should validate_presence_of :last_name}
  it {should validate_presence_of :email}

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:uid) }
end

describe 'user creation validation:' do

  it 'should have a valid factory' do
      FactoryGirl.build(:user).should be_valid
  end

  it 'should not allow creation without first_name' do
      FactoryGirl.build(:user, :first_name => '').should_not be_valid
  end

  it 'should not allow creation without last_name' do
      FactoryGirl.build(:user, :last_name => '').should_not be_valid
  end

  it 'should not allow creation without email' do
      FactoryGirl.build(:user, :email => '').should_not be_valid
  end

end

describe 'general user creation:' do

  it 'should increase Users by 2' do
    expect {
      FactoryGirl.create(:user)
      FactoryGirl.create(:user)
    }.to change(User, :count).by(2)
  end

  it 'should not default two attributes to false' do
    user = FactoryGirl.build(:user)
    expect(user.is_ambassador).to eq false
    expect(user.ambassador_availability).to eq false
  end

end

describe 'user methods:' do

  user = FactoryGirl.build(:user)

  describe 'name method:' do
    it 'returns full name as a string' do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end

  describe 'has_specialty method:' do

    user = FactoryGirl.build(:user)

    s1 = Specialty.new(specialty: "History")
    s2 = Specialty.new(specialty: "Nightlife")
    s3 = Specialty.new(specialty: "Food")

    user.specialties << s1
    user.specialties << s2
    user.specialties << s3

    it 'should have the History specialty' do
      expect(user.has_specialty?(s1)).to eq true
    end

    it 'should have the Food specialty' do
      expect(user.has_specialty?(s3)).to eq true
    end
  end

end






















