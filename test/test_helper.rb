ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# mocking carrierwave with file storage
CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
  config.root = File.join(Rails.root, 'tmp')
end

QrCodeUploader.storage :file

# mocking omniauth logins
OmniAuth.config.test_mode = true

require 'webmock/minitest'
require 'mocha/setup'
require 'capybara/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

ActiveRecord::Base.class_eval do
  def self.fixture(sym)
    find(ActiveRecord::FixtureSet.identify(sym))
  end
end

class CapybaraTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    Capybara.reset_sessions!
    super
  end

  protected

  def login_user(user_sym)
    user = User.fixture(user_sym)
    token = user.user_tokens.first

    OmniAuth.config.mock_auth[token.provider.to_sym] = OmniAuth::AuthHash.new({
      provider: token.provider,
      uid: token.uid
    })
    visit '/login'
    click_on "Login via Facebook"
  end
end