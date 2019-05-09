class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :validatable, :invitable
  attr_accessor :role
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :projects, through: :user_roles
  has_many :projects_templates, through: :projects, source: :templates
  has_and_belongs_to_many :projects_locations, class_name: 'Location'

  def templates
    projects_templates.joins(:role).where('roles.id = ?', roles.map(&:id)).distinct
  end

  def locations
    projects_locations.joins(:project).where('projects.id = ?', projects.map(&:id)).distinct
  end
end
