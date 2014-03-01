require_relative '../spec_helper'

describe Review do
  # Association Testing
  it { should belong_to(:reviewer).class_name('User') }
  it { should belong_to(:reviewee).class_name('User') }
  it { should belong_to(:meetup) }
  # Validaiton Testing
  it { should validate_presence_of(:rating) }
  it { should validate_presence_of(:comment) }
  it { should validate_presence_of(:reviewer_id) }
  it { should validate_presence_of(:reviewee_id) }
end

