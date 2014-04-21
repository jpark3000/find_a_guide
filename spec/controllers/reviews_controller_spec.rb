require_relative '../spec_helper'
include OmniauthMacros

describe ReviewsController do
  # let(:user) { FactoryGirl.create(:user) } #{User.create(first_name: "John", last_name: "Smith", email: "john@dbc.com")}
  # let(:meetup) {FactoryGirl.create(:meetup) } #{Meetup.create(ambassador_id: 1, visitor_id: 1, date_time: Time.now, address: '123 St.', tour_id: 1)}
  # let(:review) { FactoryGirl.create(:review, reviewer_id: user.id, meetup_id: meetup.id)}
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  # Route Testing
  describe "GET reviews#index" do
    it "renders the :index template for the user" do
      # login_user(@user.id)
      # set_omniauth_environment
      get :index, {user_id: @user.id}
      expect(response).to render_template :index
    end
  end

  describe "GET reviews#new" do
    it "renders the :new template for the user" do
      login_user(@user.id)
      set_omniauth_environment
      get :new, {user_id: @user.id}
      expect(response).to render_template :new
    end
  end

  # describe "POST reviews#create" do
  #   it "redirects to ______ after review creation" do
  #     # login_user(@user.id)
  #     # set_omniauth_environment
  #     post :create, user_id: @user.id, review: attributes_for(:review), format: :json
  #     expect(response).to be_success #Hope this is correct. Haha.
  #   end
  # end

  #Object Creation Testing

  describe "POST reviews#create" do
    it "expect a new reviews object to be created" do
      pending
    end
  end

end #End ReviewsController controller

