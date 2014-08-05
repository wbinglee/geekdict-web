class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
    	t.integer :user_id
    	t.string :query
      t.timestamps
    end
  end
end
