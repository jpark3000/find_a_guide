OmniAuth.config.logger = Rails.logger

# ENV_CONFIG = YAML.load_file(APP_ROOT.join('config', 'facebook.yaml'))

# ENV_CONFIG.each do |key, value|
#   ENV[key] = value
# end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '372074249602099', '0f949799be0750651814f5e90f5397f3'
end
