ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


CarrierWave.configure do |config|
  config.storage = :file
  config.enable_processing = false
  config.root = File.join(Rails.root, 'tmp')
end

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
