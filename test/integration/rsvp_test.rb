require 'test_helper'

class RsvpTest < CapybaraTest

  def test_admin_can_view_invites
    login_user(:jeff)

    visit '/rsvp'
    rsvps = Rsvp.all
    rsvps.each do |rsvp|
      assert has_link?(rsvp.name)
    end
  end

  def test_normal_user_cannot_view_invites
    visit '/rsvp'
    rsvps = Rsvp.all
    rsvps.each do |rsvp|
      assert has_no_link?(rsvp.name)
    end
  end

  def test_can_create_rsvp
    login_user(:jeff)

    visit '/rsvp'
    assert has_selector?('h1', text: 'RSVP')

    assert has_link?('New Invitation')
    click_on 'New Invitation'

    fill_in 'Name', with: 'John Smith'
    fill_in 'Email address', with: 'john@smith.com'
    fill_in 'Max attending', with: '2'
    fill_in 'Line 1', with: '123 Main St'
    fill_in 'City', with: 'Seattle'
    fill_in 'State', with: 'WA'
    fill_in 'Zip', with: '98115'
    click_on 'Create Rsvp'

    assert has_selector?('.alert.alert-success')

    assert has_link?('John Smith')
  end

  def test_can_rsvp

  end

end