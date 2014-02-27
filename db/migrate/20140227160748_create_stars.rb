class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
    	t.integer :star
    	t.timestamps
    end
  end
end
