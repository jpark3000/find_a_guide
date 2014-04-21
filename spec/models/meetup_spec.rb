require_relative '../spec_helper'

describe Meetup do
  user1 = FactoryGirl.build(:user)
  user2 = FactoryGirl.build(:user)

  meetup = FactoryGirl.build(:meetup, :ambassador_id => user1.id, :visitor_id => user2.id)
  # Association Tests
  it { should belong_to(:ambassador).class_name('User') }
  it { should belong_to(:visitor).class_name('User') }
  it { should belong_to(:tour) }
  it { should have_many(:reviews) }

  # Validation Tests
  # Commented out because of conflicts with you_cannot_meet_with_nonambassador method.
  # it { should validate_presence_of :ambassador_id }
  # it { should validate_presence_of :visitor_id }

  # Method Tests
  describe 'method: you_cannot_meet_with_yourself' do
    pending
  end

  describe 'method: you_cannot_meet_with_nonambassador' do
    pending
  end

  describe 'method: self.pending_meetups' do
    pending
  end

  describe 'method: self.completed_meetups' do
    pending
  end

end

