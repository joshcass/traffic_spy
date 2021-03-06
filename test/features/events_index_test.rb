require_relative '../test_helper'

class EventsIndexTest < FeatureTest
  def test_user_sees_no_event_source_error_page
    create_source("jumpstartlab", "http://jumpstartlab.com")
    visit '/sources/jumpstartlab/events'

    within("#every_error") do
      assert page.has_content?("Why you no have event?")
    end
  end

  def test_user_sees_most_recieved_event
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/events'
    within("#events ol:first-child") do
      assert page.has_content?("socialLogin")
    end
  end

  def test_when_user_clicks_on_event_link_they_see_event_detail_page
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/events'
    within("#events ol:first-child") do
      click_on("socialLogin")
      assert_equal '/sources/jumpstartlab/events/socialLogin', current_path
    end
  end
end
