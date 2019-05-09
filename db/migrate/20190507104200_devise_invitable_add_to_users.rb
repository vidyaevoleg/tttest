class DeviseInvitableAddToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true, unique: true
      t.string :name
      t.string :encrypted_password, null: false, default: ""
      t.string   :reset_password_token, index: true
      t.datetime :reset_password_sent_at
      t.string :invitation_token, index: true
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer :invitation_limit
      t.references :invited_by, polymorphic: true, index: true
      t.integer :invitations_count, default: 0
    end
  end
end
