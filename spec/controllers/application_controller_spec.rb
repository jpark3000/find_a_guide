require_relative '../spec_helper'
include OmniauthMacros

describe ApplicationController do

  describe 'GET#index' do
    context 'without active session' do
      it 'should render Application#Index' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'with active session' do
      mock_auth_hash
      it 'should render Application#Index' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

end


