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
    ken = Rsvp.fixture(:ken)
    assert_equal false, ken.responded?
    visit reply_rsvp_path(ken)

    assert has_text?("will you be attending?")
    choose 'Yes'

    fill_in "Total number attending", with: '3'
    fill_in "Notes", with: "See you there slugger!"
    click_on "Respond"

    assert has_selector?('.alert.alert-success')
    assert has_selector?('h1', text: 'Registry'), 'should be on registry page after rsvping'
  end

  def test_can_edit_rsvp
    mark = Rsvp.fixture(:mark)
    assert mark.responded?
    visit reply_rsvp_path(mark)

    assert has_text?("will you be attending?")
    choose 'Yes'

    fill_in "Total number attending", with: '1'
    fill_in "Notes", with: "Actually I can make it after all"
    click_on "Respond"

    assert has_selector?('.alert.alert-success')
    assert has_selector?('h1', text: 'Registry'), 'should be on registry page after rsvping'
  end

  def test_can_modify_an_invite
    login_user(:jeff)

    ken = Rsvp.fixture(:ken)
    assert ken.address
    visit edit_rsvp_path(ken)

    fill_in "Max attending", with: 10
    click_on "Update Rsvp"

    assert has_selector?('h1', text: 'RSVP')
    assert has_text?('Max Attending: 10')
  end

end