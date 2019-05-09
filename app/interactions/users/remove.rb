module Users
  class Remove < ApplicationInteraction
    # TYPE CHECK
    object :user, class: User
    integer :project_id
    integer :role_id

    # BUSINESS LOGIC VALIDATION
    validate :check_project
    validate :check_user_role

    def execute
      ActiveRecord::Base.transaction do
        user.projects_locations = user.projects_locations.where.not(project_id: project_id)
        @user_role.destroy!
      end
    end

    private

    def check_project
      unless @project = user.projects.find_by(id: project_id)
        errors.add(:project_id, :invalid)
        throw(:abort)
      end
    end

    def check_user_role
      unless @user_role = UserRole.find_by(user: user, project: @project, role_id: role_id)
        errors.add(:role_id, :invalid)
      end
    end
  end
end
