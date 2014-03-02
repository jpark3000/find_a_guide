require_relative '../spec_helper'

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

