require_relative '../spec_helper'

describe Tour do
  #Association Test
  it { should belong_to(:ambassador).class_name('User') }
  it { should have_many(:meetups) }

  #Validation Test
  # it { should validate_presence_of :ambassador_id }
  # it { should validate_presence_of :longitude }
  # it { should validate_presence_of :latitude }
  # it { should validate_presence_of :description }

  # Model Tests
  describe 'Method Tests' do
    describe 'you_cannot_drop_pin_if_notambassador' do
      pending
    end

    describe 'format_coordinates' do
      pending
    end

    describe 'tour_to_json' do
      pending
    end
  end
end
