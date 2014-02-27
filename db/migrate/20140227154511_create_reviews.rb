class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.integer :rating
    	t.text :comment
    	t.references :meetup
    	t.references :reviewer
    	t.references :reviewee
    	t.timestamps
    end
  end
end
