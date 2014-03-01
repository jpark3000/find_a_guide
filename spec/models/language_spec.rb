require_relative '../spec_helper'

describe Language do
  # Association Testing
  it { should have_many(:languages_spoken) }
  it { should have_many(:users).through(:languages_spoken) }
  # Validaiton Testing
  it { should validate_presence_of(:language) }
end

