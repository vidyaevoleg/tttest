require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'POST invite' do
    context 'success' do
      subject do
        post '/users/invite', params: { user: { email: 'test@test.ru' } }
      end

      it 'respond with 200' do
        subject
        expect(response.code).to eq('200')
      end
    end
  end
end
