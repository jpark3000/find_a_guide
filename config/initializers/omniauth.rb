OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 372074249602099, 0f949799be0750651814f5e90f5397f3
end
