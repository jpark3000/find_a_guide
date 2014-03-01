require_relative '../spec_helper'

describe Specialty do
  # Association Testing
  it { should have_many(:users_specialties) }
  it { should have_many(:users).through(:users_specialties) }
  # Validaiton Testing
  it { should validate_presence_of(:specialty) }
end
