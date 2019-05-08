class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable, :invitable

  has_and_belongs_to_many :roles
  has_many :projects, through: :roles
  has_many :project_templates, through: :projects, source: :templates
  has_and_belongs_to_many :locations
  # has_many :roles_users, dependent: :delete_all
  # has_many :roles, through: :roles_users
  # has_many :projects, through: :roles

  def subscribed_templates
    project_templates.joins(:role).where('roles.id = ?', roles.map(&:id)).distinct
  end
end
