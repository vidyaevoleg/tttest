ActiveRecord::Base.transaction do
  User.destroy_all
  Project.destroy_all
  Role.destroy_all

  user = User.create!(email: 'test@test.ru', password: '12345678')
  role = Role.create!(name: :admin)
  project = Project.create!(name: 'Awesome Project')
  user_role = UserRole.create(user: user, project: project, role: role)
  location = Location.create(name: 'Awesome Location', project: project)
  template = Template.create(name: 'Awesome Template', role: role, project: project)
  user.projects_locations << location
end
