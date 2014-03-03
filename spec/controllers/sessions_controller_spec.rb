require_relative '../spec_helper'
include OmniauthMacros

describe SessionsController do

  describe 'signout/sessions#destroy' do
    it 'should render Application#Index' do
      post :destroy
      expect(response).to redirect_to '/'
    end
  end

  describe 'signin/sessions#create' do
    # mock_auth_hash
    # set_omniauth_environment

    # it 'should render Application#Index' do
    #   post :create
    #   expect(response).to redirect_to '/'
    # end
    pending
  end


end # End sessions controller

# request.env["omniauth.auth"] = mock_auth_hash

# mock_auth_hash
