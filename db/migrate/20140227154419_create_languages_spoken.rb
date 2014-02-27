class CreateLanguagesSpoken < ActiveRecord::Migration
  def change
    create_table :languages_spokens do |t|
    	t.references :user
    	t.references :language
    end
  end
end
