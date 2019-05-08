class Role < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :projects
  has_many :templates, dependent: :destroy
end
