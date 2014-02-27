class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
    	t.string :provider
    	t.string :uid
    	t.string :oauth_token
    	t.time :oauth_expires_at
    	t.timestamps
    end
  end
end
