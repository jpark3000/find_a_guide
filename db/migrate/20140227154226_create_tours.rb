class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
    	t.references :ambassador
    	t.float :longitude
    	t.float :latitude
    	t.text :description
    end
  end
end
