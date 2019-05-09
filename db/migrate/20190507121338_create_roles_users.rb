class CreateRolesUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles do |t|
      t.references :project
      t.references :role
      t.references :user
    end
  end
end
