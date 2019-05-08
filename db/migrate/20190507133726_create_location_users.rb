class CreateLocationUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :locations, :users do |t|
      t.index [:location_id, :user_id]
    end
  end
end
