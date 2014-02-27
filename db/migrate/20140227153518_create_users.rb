class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.string :phone
    	t.string :profile_pic
    	t.text :bio
    	t.string :gender
    	t.integer :age
    	t.boolean :is_ambassador
    	t.boolean :ambassador_availability
    	t.string :tagline
    	t.references :authentication
    end
  end
end
