require 'test_helper'

class RsvpModelTest < ActiveSupport::TestCase

  def test_destroying_invite_destroys_address
    ken = Rsvp.fixture(:ken)
    assert ken.address

    assert_difference "Rsvp.count", -1 do
      assert_difference "Address.count", -1 do
        assert ken.destroy
      end
    end
  end

end