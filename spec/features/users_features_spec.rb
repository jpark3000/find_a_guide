require 'spec_helper'

# feature 'User viewing and editing profile data' do

#   let(:user) {User.create(first_name: "John", last_name: "Smith", email: "john@dbc.com")}

#   before(:each) do
#     page.set_rack_session(:user_id => user.id)
#   end

#   context "on users#show" do
#     it "allows a logged in user to see their information" do
#       visit user_path(user)
#       expect(page).to have_content("john@dbc.com")
#     end

#     it "prevents a logged in user from viewnig someone else's private info." do
#       user2 = User.create(first_name: "Jane", last_name: "Smith", email: "jane@dbc.com")
#       visit user_path(user2)
#       expect(page).to have_no_content("jane@dbc.com")
#     end
#   end
# end
