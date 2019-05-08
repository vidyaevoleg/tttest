class CreateRolesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :roles, :users do |t|
      t.index [:role_id, :user_id]
    end
  end
end
