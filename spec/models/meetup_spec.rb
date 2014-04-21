require_relative '../spec_helper'

describe Meetup do
  # Association Tests
  it { should belong_to(:ambassador).class_name('User') }
  it { should belong_to(:visitor).class_name('User') }
  it { should belong_to(:tour) }
  it { should have_many(:reviews) }

  # Validation Tests
  # Commented out because of conflicts with you_cannot_meet_with_nonambassador method.
  # it { should validate_presence_of(:ambassador_id) }
  # it { should validate_presence_of(:visitor_id) }

  # Method Tests
  describe 'you_cannot_meet_with_yourself' do
    pending
  end

  describe 'you_cannot_meet_with_nonambassador' do
    pending
  end

  describe 'self.pending_meetups' do
    pending
  end

  describe 'self.completed_meetups' do
    pending
  end

end

