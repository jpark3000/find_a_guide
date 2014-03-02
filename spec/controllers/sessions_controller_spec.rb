require_relative '../spec_helper'
include OmniauthMacros

describe SessionsController do

  # describe 'failure' do
  #   it 'should respond with 301' do
  #     request.env["omniauth.auth"] = :invalid_credentials
  #     post :create

  #     expect(response.status).to eq(301)
  #   end
  # end

  # describe 'signout' do
  #   before do
  #     request.env["omniauth.auth"] = mock_auth_hash
  #   end

  #   login_user(1)

  #   it 'should be successful' do
  #     get 'destroy'
  #     expect(response).to be_success
  #   end
  # end

  # describe 'GET#index' do
  #   before do
  #       request.env["omniauth.auth"] = mock_auth_hash
  #   end

  #   context 'without active session' do
  #     it 'should render Application#Index' do
  #       get :sessions
  #       expect(response).to render_template :index
  #     end
  #   end

  #   context 'with active session' do
  #     mock_auth_hash
  #     it 'should render Application#Index' do
  #       get :index
  #       expect(response).to render_template :index
  #     end
  #   end
  # end

  # describe 'CREATE#index' do
  #   context 'without active session' do
  #     it 'should render Application#Index' do
  #       get :index
  #       expect(response).to render_template :index
  #     end
  #   end

  #   context 'with active session' do
  #     mock_auth_hash
  #     it 'should render Application#Index' do
  #       get :index
  #       expect(response).to render_template :index
  #     end
  #   end
  # end

  # describe 'DESTROY#index' do
  #   context 'without active session' do
  #     it 'should render Application#Index' do
  #       get :index
  #       expect(response).to render_template :index
  #     end
  #   end

  #   context 'with active session' do
  #     mock_auth_hash
  #     it 'should render Application#Index' do
  #       get :index
  #       expect(response).to render_template :index
  #     end
  #   end
  # end

end

# request.env["omniauth.auth"] = mock_auth_hash

# mock_auth_hash
