require_relative '../test_helper'

class EventDetailsTest < FeatureTest
  def test_user_sees_unknown_source
    skip
    visit '/sources/jumpstartlab'

    within("#every_error") do
      assert page.has_content?("You're in a coma right now. This is a signal telling you to wake up. Also, this identifier does not exist")
    end
  end

  def test_user_sees_breakdown_of_events_by_hour
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/events/socialLogin'
    within("#event_breakdown") do
      assert page.has_content?("12am: 1")
    end
  end
end

