class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.references :star
    	t.text :comment
    	t.references :reviewer
    	t.references :reviewee
    	t.timestamps
    end
  end
end
