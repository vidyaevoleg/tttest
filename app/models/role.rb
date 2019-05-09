class Role < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :projects, through: :user_roles
  # has_and_belongs_to_many :projects
  # has_many :templates, dependent: :destroy
end
