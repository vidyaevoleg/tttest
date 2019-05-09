class Project < ApplicationRecord
  has_many :user_roles, dependent: :destroy
  has_many :users, through: :user_roles
  has_many :roles, through: :user_roles
  has_many :templates, dependent: :destroy
  has_many :locations, dependent: :destroy
end
