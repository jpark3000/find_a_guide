class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |t|
    	t.references :ambassador
    	t.references :visitor
    	t.datetime :date_time
    	t.string	:address
    	t.references :tour
    	t.text	:meetup_notes
        t.timestamps
    end
  end
end
