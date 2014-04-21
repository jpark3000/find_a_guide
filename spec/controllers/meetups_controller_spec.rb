require_relative '../spec_helper'
include OmniauthMacros

# describe MeetupsController, :type => :controller do
#   let(:user) {User.create(first_name: "John", last_name: "Smith", email: "john@dbc.com")}
#   let(:meetup) {Meetup.create(ambassador_id: 1, visitor_id: 1, date_time: Time.now, address: '123 St.', tour_id: 1)}

#   describe "#update" do
#     it "allows an ambassador to update a meetup he or she hosts." do
#       ApplicationController.any_instance.stub(:current_user).and_return(user)
#       put :update, user_id: user.id, id: meetup.id, meetup: {date_time: Time.now, meetup_notes: 'some notes'}
#       expect(Meetup.find(meetup.id).meetup_notes).to eq('some notes')
#     end
#   end
# end

describe MeetupsController do

  let(:user) { FactoryGirl.create(:user) }

  # Route Testing
  describe "GET meetups#index" do
    it "renders the :index template for the tour" do
      get :index, {user_id: user.id}
      expect(response).to render_template :index
    end
  end

  # describe "GET tours#edit" do
  #   it "renders the :edit template for the tour" do
  #     user = FactoryGirl.create(:user)
  #     user.visitor_meetups.create(FactoryGirl.attributes_for(:meetup, ambassador_id: user.id))

  #     get :edit, {user_id: user.id, id: user.visitor_meetups.last.id}
  #     expect(response).to render_template :edit
  #   end
  # end

  # describe "GET tours#show" do
  #   user = FactoryGirl.create(:user)
  #   user.visitor_meetups.create(FactoryGirl.attributes_for(:meetup, ambassador_id: user.id))
  #   it "renders the :show template for the tour" do
  #     get :show, user_id: user.id, id: user.visitor_meetups.last.id
  #     expect(response).to render_template :show
  #   end
  # end

  #Object Creation Testing

  describe "POST  meetups#create_______" do
    it "_______________" do
      pending
    end
  end

  describe "PATCH meetups#update _______" do
    it "_______________" do
      pending
    end
  end

  describe "PUT meetups#update _______" do
    it "_______________" do
      pending
    end
  end

end #End ReviewsController controller
