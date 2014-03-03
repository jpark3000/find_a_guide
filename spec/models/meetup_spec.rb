require_relative '../spec_helper'

describe Meetup do
  # Association Testing
  it { should belong_to(:ambassador).class_name('User') }
  it { should belong_to(:visitor).class_name('User') }
  it { should belong_to(:tour) }
  it { should have_many(:reviews) }
  # Validaiton Testing
  it { should validate_presence_of(:ambassador_id) }
  it { should validate_presence_of(:visitor_id) }
end

