require_relative '../spec_helper'

describe LanguagesSpoken do
  # Association Testing
  it { should belong_to(:user) }
  it { should belong_to(:language) }
  # Validaiton Testing
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:language_id) }
end

