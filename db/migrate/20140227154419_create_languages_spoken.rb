class CreateLanguagesSpoken < ActiveRecord::Migration
  def change
    create_table :languages_spokens do |t|
    	t.references :user
    	t.references :language
    	t.timestamps
    end
  end
end
