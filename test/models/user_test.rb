require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def test_jeff_is_admin
    user = User.fixture(:jeff)
    assert user.admin?
  end

  def test_kyle_is_normal_user
    user = User.fixture(:other)
    assert_equal false, user.admin?
  end

end