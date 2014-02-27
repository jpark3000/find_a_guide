class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
    	t.references :ambassador_id
    	t.references :visitor_id
    	t.datetime :date_time
    	t.string	:address
    	t.references :tour
    	t.text	:meetup_notes
    end
  end
end
