class ProjectsRole < ApplicationRecord
  belongs_to :role
  belongs_to :project
end