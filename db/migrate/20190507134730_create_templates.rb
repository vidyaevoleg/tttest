class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :name
      t.references :project, index: true
      t.references :role, index: true
    end
  end
end
