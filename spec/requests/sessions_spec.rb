require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  include_context 'test_domain'

  it 'GET /login' do
    get '/login'
    expect(response.body).to include('Hello')
  end

  describe 'POST /login' do
    it 'with confirm_email honey trap' do
      expect{ post new_session_path, params: { email: 'john@example.com', confirm_email: 'john@example.com' } }.to raise_error ArgumentError
    end

    it 'with invalid email address' do
      expect{ post new_session_path, params: { email: 'invalid' } }.to raise_error ArgumentError
    end

    context 'with valid email addresses' do
      let!(:user) { Fabricate :card, email: 'john@example.com' }

      it 'not part of user database' do
        post new_session_path, params: { email: 'jane@example.com' }
        expect(response).to redirect_to new_session_path(email: 'jane@example.com', error: 'Nope! Try Again.')
      end

      it 'from user database' do
        post new_session_path, params: { email: 'john@example.com' }
        expect(response.body).to include('Sent')
      end
    end
  end

  describe 'GET /auth' do
    context 'with user' do
      let!(:user) { Fabricate :card, email: 'john@example.com' }

      it 'and valid credentials' do
        user.create_auth
        get auth_session_path user_id: user.id.to_s, token: user.auth.token
        expect(response).to redirect_to root_url
        expect(user.reload.has_auth?).to be false
        expect(session['user_id']).to eq user.id.to_s
        delete '/logout'
        expect(response).to redirect_to '/login'
        expect(session['user_id']).to be nil
      end
    end
  end

end