class Template < ApplicationRecord
  belongs_to :role
  belongs_to :project

  def subscribers
    project.users.joins(:roles).where('roles_users.role_id = ?', role_id).distinct
  end
end
