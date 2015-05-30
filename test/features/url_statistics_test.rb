require_relative '../test_helper'

class ClientDashboardTest < FeatureTest
  def test_user_sees_error_message_when_url_never_requested
    create_source("jumpstartlab", "http://jumpstartlab.com")
    visit '/sources/jumpstartlab/urls/blog'
    within("#every_error") do
      assert page.has_content?("The path /blog is lonely, so lonely, because it has never been requested.")
    end
  end

  def test_user_sees_longest_response_time
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#longest_response") do
      assert page.has_content?("Longest Response Time: 93")
    end
  end

  def test_user_sees_shortest_response_time
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#shortest_response") do
      assert page.has_content?("Shortest Response Time: 91")
    end
  end

  def test_user_sees_average_response_time
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#average_response") do
      assert page.has_content?("Average Response Time: 92")
    end
  end

  def test_user_sees_http_verbs_used
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#http_verbs ul > :first-child") do
      assert page.has_content?("GET")
    end
  end

  def test_user_sees_most_popular_referrers_used
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#top_referrers ol:first-child") do
      assert page.has_content?("http://google.com")
    end
  end

  def test_user_sees_most_popular_browsers
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#top_browsers ol:first-child") do
      assert page.has_content?("Chrome")
    end
  end

  def test_user_sees_most_popular_os
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    visit '/sources/jumpstartlab/urls/blog'
    within("#top_os ol:first-child") do
      assert page.has_content?("OS X 10.8.2")
    end
  end
end
