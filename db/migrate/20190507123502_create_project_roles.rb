class CreateProjectRoles < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :roles do |t|
      t.index [:project_id, :role_id]
    end
  end
end
