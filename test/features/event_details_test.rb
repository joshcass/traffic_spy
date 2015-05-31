require_relative '../test_helper'

class EventDetailsTest < FeatureTest
  def test_user_sees_unknown_source
    create_source("jumpstartlab", "http://jumpstartlab.com")

    visit '/sources/jumpstartlab/events/socialLogin'
    within("#every_error") do
      assert page.has_content?("socialLogin's? I don't believe they exist. Click here to go to the event index for Jumpstartlab.")
    end
  end

  def test_clicking_on_event_index_link_from_error_page_user_sees_event_index
    create_source("jumpstartlab", "http://jumpstartlab.com")

    visit '/sources/jumpstartlab/events/socialLogin'
    within("#every_error") do
      click_on("Click here to go to the event index for Jumpstartlab.")
      assert_equal '/sources/jumpstartlab/events', current_path
    end
  end

  def test_user_sees_breakdown_of_events_by_hour
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/events/socialLogin'
    within("#hourly_breakdown") do
      assert page.has_content?("4AM: 2")
    end
  end

  def test_user_sees_total_times_event_was_received
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/events/socialLogin'
    within("#total_received") do
      assert page.has_content?("Received a total of 3 times")
    end
  end
end

