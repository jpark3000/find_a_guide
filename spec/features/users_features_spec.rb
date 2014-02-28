require 'spec_helper'

feature 'User viewing and editing profile data' do

  let(:user) {User.create(first_name: "John", last_name: "Smith", email: "john@dbc.com")}

  before(:each) do
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    page.set_rack_session(:user_id => user.id)
  end

  context "on users#show" do
    it "allows a logged in user to see their information" do
      visit user_path(current_user)
      expect(page).to have_content("john@dbc.com")
    end
  end
end
