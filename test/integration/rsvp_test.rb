require 'test_helper'

class RsvpTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def test_foo
    visit '/'
    assert has_text?("Jeff & Diana's Wedding")
  end
end