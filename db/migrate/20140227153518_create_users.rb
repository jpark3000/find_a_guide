class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.string :provider
        t.string :uid
        t.string :oauth_token
        t.time :oauth_expires_at

        t.string :profile_pic

    	t.string :first_name
    	t.string :last_name
    	t.string :email
    	t.string :phone
    	t.string :username
    	t.text :bio
    	t.string :gender
    	t.string :age
    	t.boolean :is_ambassador, :default => 'false'
    	t.boolean :ambassador_availability, :default => 'false'

    	t.string :tagline
        t.string :anonymous_email
    	t.references :authentication
        t.timestamps
    end
  end
end
