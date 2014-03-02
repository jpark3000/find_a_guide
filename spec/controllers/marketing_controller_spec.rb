require_relative '../spec_helper'
include OmniauthMacros

# describe UsersController, :type => :controller do
#   let(:user) {User.create(first_name: "John", last_name: "Smith", email: "john@dbc.com")}

#   describe "#update" do
#     it "the user is able to update his profile." do
#       ApplicationController.any_instance.stub(:current_user).and_return(user)
#       put :update, id: user.id, user: {email: 'new_email@dbc.com', phone: '123', gender: 'male', bio: 'blah blah', age: 32}
#       expect(User.find(user.id).email).to eq('new_email@dbc.com')
#     end
#   end
# end

describe MarketingController do

  describe 'Routing & Rendering' do

    describe 'GET#Index' do
      it 'should render user index template' do
        pending
        # get :index
        # expect(response).to render_template :index
      end
    end

    describe 'GET#Thanks' do
      it 'should render user thanks template' do
        pending
        # get :thanks
        # expect(response).to render_template :thanks
      end
    end

  end #End Routing and Rendering

end #End MarketingController describe
