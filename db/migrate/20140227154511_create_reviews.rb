class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.references :star
    	t.text :comment
    	t.references :reviewer
    	t.references :reviewee
    end
  end
end
