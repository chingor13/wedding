Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  facebook_config = Rails.application.config_for(:facebook)
  provider :facebook, facebook_config['app_id'], facebook_config['app_secret'], scope: 'email,public_profile'
end