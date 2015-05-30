require_relative '../test_helper'

class ClientDashboardTest < FeatureTest
  def test_user_sees_unknown_source
    visit '/sources/jumpstartlab'

    within("#every_error") do
      assert page.has_content?("You're in a coma right now. This is a signal telling you to wake up. Also, the identifier jumpstartlab does not exist")
    end
  end
  
  def test_a_client_page_exist_for_known_source
    create_source("jumpstartlab", "http://jumpstartlab.com")
    visit '/sources/jumpstartlab'
    within("#welcome") do
      assert page.has_content?("Welcome to Traffic Spy")
    end
  end

  def test_user_sees_most_requested_urls
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab'
    within("#most_visited_urls ol:first-child") do
      assert page.has_content?("http://jumpstartlab.com/blog")
    end
  end

  def test_user_sees_urls_ranked_by_average_response_time
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab'
    within("#average_response_times ol:first-child") do
      assert page.has_content?("http://jumpstartlab.com/blog")
    end
  end

  def test_user_sees_web_browser_breakdown_for_all_requests
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab'
    within("#browser_breakdown ol:first-child") do
      assert page.has_content?("Chrome")
    end
  end

  def test_user_sees_os_breakdown_for_all_requests
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab'
    within("#os_breakdown ol:first-child") do
      assert page.has_content?("OS X 10.8.2")
    end
  end

  def test_user_sees_screen_resolution_breakdown_for_all_requests
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab'
    within("#screen_res_breakdown ol:first-child") do
      assert page.has_content?("1920 x 1280")
    end
  end
end
