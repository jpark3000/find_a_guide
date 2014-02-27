class CreateSpecialties < ActiveRecord::Migration
  def change
    create_table :specialties do |t|
    	t.string :specialty
    end
  end
end
