require 'spec_helper'

describe UsersController, :type => :controller do
  let(:user) {User.create(first_name: "John", last_name: "Smith", email: "john@dbc.com")}

  describe "#update" do
    it "the user is able to update his profile." do
      put :update, id: user.id, email: 'new_email@dbc.com'
      expect(User.find(user.id).email).to eq('new_email@dbc.com')
    end
  end
end

