class Project < ApplicationRecord
  has_and_belongs_to_many :roles
  has_many :users, through: :roles
  has_many :templates, dependent: :destroy
  # has_many :projects_roles, dependent: :delete_all
  # has_many :roles, through: :projects_roles
end
