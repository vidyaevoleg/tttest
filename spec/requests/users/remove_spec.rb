require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'POST #remove' do
    let!(:role) { create(:role) }
    let!(:project) { create(:project) }
    let!(:project_2) { create(:project) }
    let!(:user) { create(:user) }
    let!(:user_role) { create(:user_role, role: role, project: project, user: user) }
    let!(:user_role_2) { create(:user_role, role: role, project: project_2, user: user) }
    let!(:template) { create(:template, role: role, project: project) }
    let!(:location) { create(:location, project: project, users: [user]) }
    let!(:location_2) { create(:location, project: project_2, users: [user]) }

    context 'success' do
      subject do
        post "/users/#{user.id}/remove", params: { user: {
          project_id: project.id,
          role_id: role.id,
        } }
      end

      it 'should respond with 200' do
        subject
        expect(response.code).to eq('200')
      end

      it 'should remove project assocation' do
        expect { subject }.to change(user.projects, :count).by(-1)
      end

      it 'should remove templates' do
        expect { subject }.to change(user.projects_templates, :count).by(-1)
      end

      it 'should remove user locations' do
        expect { subject }.to change(user.projects_locations, :count).by(-1)
      end
    end

    context 'failure' do
      context 'empty params' do
        subject do
          post "/users/#{user.id}/remove"
        end

        it_behaves_like 'response_422'

        it 'should have role and project errors' do
          subject
          expect(json[:errors][:role_id].present?).to eq(true)
          expect(json[:errors][:project_id].present?).to eq(true)
        end
      end

      context 'invalid role' do
        subject do
          post "/users/#{user.id}/remove", params: { user: {
            project_id: project.id,
            role_id: 1212
          } }
        end

        it_behaves_like 'response_422'

        it 'should have role error' do
          subject
          expect(json[:errors][:role_id].present?).to eq(true)
        end
      end

      context 'invalid project' do
        subject do
          post "/users/#{user.id}/remove", params: { user: {
            project_id: 121212,
            role_id: user_role.role_id
          } }
        end

        it_behaves_like 'response_422'

        it 'should have project error' do
          subject
          expect(json[:errors][:project_id].present?).to eq(true)
        end
      end
    end
  end
end
