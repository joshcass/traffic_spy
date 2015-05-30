require_relative '../test_helper'

class EventDetailsTest < FeatureTest
  def test_user_sees_unknown_source
    create_source("jumpstartlab", "http://jumpstartlab.com")

    visit '/sources/jumpstartlab/events/socialLogin'
    within("#every_error") do
      assert page.has_content?("No socialLogin event has been defined. Click here to go to the event index for Jumpstartlab.")
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

