require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'POST invite' do
    let!(:role) { create(:role) }
    let!(:project) { create(:project) }
    let!(:template) { create(:template, role: role, project: project) }
    let!(:location) { create(:location, project: project) }

    context 'success' do
      subject do
        post '/users/invite', params: { user: {
          name: 'Alex',
          email: 'test@test.com',
          project_id: project.id,
          role_id: role.id,
          location_id: location.id
        } }
      end

      it_behaves_like 'response_200'

      it 'should create user' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'should create new subscribtion' do
        expect { subject }.to change(template.subscribers, :count).by(1)
      end

      it 'should bind project, user, role' do
        subject
        user = User.last
        expect(user.projects.last).to eq(project)
        expect(user.locations.last).to eq(location)
        expect(user.roles.last).to eq(role)
      end

      it 'should invite user' do
        subject
        user = User.last
        expect(user.invitation_sent_at.present?).to eq(true)
        expect(user.invitation_token.present?).to eq(true)
      end

      it 'should send invitation email' do
        expect(Devise::Mailer).to receive(:invitation_instructions)
          .and_return( double("Devise::Mailer", deliver: true) ).once
        subject
      end
    end

    context 'failure' do
      context 'empty params' do
        subject do
          post '/users/invite'
        end

        it_behaves_like 'response_422'

        it 'should provide following errors' do
          subject
          [:role_id, :name, :email, :location_id, :project_id].each do |attr|
            expect(json[:errors][attr].present?).to eq(true)
          end
        end
      end

      context 'invalid params' do
        subject do
          post '/users/invite', params: { user: {
            email: 'test2@test.com',
            name: 'Alex',
            role_id: 11111,
            project_id: 11111,
            location_id: 11111,
          } }
        end

        it_behaves_like 'response_422'

        it 'should provide following errors' do
          subject
          [:location, :role, :project].each do |attr|
            expect(json[:errors][attr].present?).to eq(true)
          end
        end
      end
    end
  end
end
