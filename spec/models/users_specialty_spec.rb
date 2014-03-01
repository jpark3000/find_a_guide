require_relative '../spec_helper'

describe UsersSpecialty do
  #Association Testing
  it { should belong_to(:user) }
  it { should belong_to(:specialty) }

  # Validation Testing
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :specialty_id}
end
