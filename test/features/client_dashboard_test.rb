require_relative '../test_helper'

# A list of URLs ranked from most requested to least requested, the list items should be links to view url specific data.
#A table showing Browser, OS, and Screen Resolutions(widthXheight) for all requests.
# A list of URLs ranked by average response time, listed in descending order.
# A link to view aggregate event data.
#As a User when I send a get request to http://yourapplication:port/sources/IDENTIFIER, and the identifier doesn't exist,
# Then I should see an error page, saying the identifier doesn't exits.


class ClientDashboardTest < FeatureTest
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
end
