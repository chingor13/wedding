amazon_config = Rails.application.config_for(:amazon)
CarrierWave.configure do |config|
  config.storage = :fog
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     amazon_config['access_key'],
    aws_secret_access_key: amazon_config['secret_access_key']
  }
  config.asset_host = "http://media.chingr.com"
  config.fog_public     = true 
  config.fog_directory  = 'media.chingr.com'
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
end