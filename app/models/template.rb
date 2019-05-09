class Template < ApplicationRecord
  belongs_to :role
  belongs_to :project

  def subscribers
    project.users.joins(:user_roles).where('user_roles.role_id = ?', role_id).distinct
  end
end
