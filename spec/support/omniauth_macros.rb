module OmniauthMacros

    def mock_auth_hash
      # The mock_auth configuration allows you to set per-provider (or default)
      # authentication hashes to return during integration testing.
      OmniAuth.config.mock_auth[:facebook] = {
        'user_info' => {
          'name' => 'Mario Brothers',
          'image' => '',
          'email' => 'dpsk@email.ru' },
        'uid' => '123545',
        'provider' => 'facebook',
        'credentials' => {'token' => 'token'}
      }
    end

    def set_omniauth_environment
      # before do
        request.env["omniauth.auth"] = mock_auth_hash
      # end
    end

    def login_user(user_id)
      session[:user_id] = user_id
    end

    def logout_user(user_id)
      if session[:user_id] == user_id
        session[:user_id] = nil
      end
    end

end
