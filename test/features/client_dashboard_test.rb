require_relative '../test_helper'
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
end
