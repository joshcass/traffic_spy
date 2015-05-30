require_relative '../test_helper'

class SourceTest < ModelTest
  def test_most_visited_urls
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal [["http://jumpstartlab.com/blog", 3], ["http://jumpstartlab.com/about", 1]], source.most_visited_urls
  end

  def test_average_response_times
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal [92, 35], source.average_response_times.map {|x,y| y.to_i}
  end

  def test_user_agents_when_path_is_not_entered_as_parameter
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal ["Chrome", "Chrome", "Internet Explorer", "Chrome"], source.user_agents.map {|agent| agent.browser}
  end

  def test_user_agents_when_path_is_entered_as_parameter
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal ["Chrome", "Internet Explorer", "Chrome"], source.user_agents("http://jumpstartlab.com/blog").map { |agent| agent.browser }
  end

  def test_browser_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal "{\"Chrome\"=>3, \"Internet Explorer\"=>1}", source.browser_breakdown.to_s
  end

  def test_os_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal "{\"OS X 10.8.2\"=>3, \"Windows 7\"=>1}", source.os_breakdown.to_s
  end

  def test_screen_res_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal [["1920", "1280"], ["800", "600"]], source.screen_res_breakdown.map {|x,y| x }
  end

  def test_longest_response
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal 93, source.longest_response("http://jumpstartlab.com/blog")
  end

  def test_shortest_response
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal 93, source.longest_response("http://jumpstartlab.com/blog")
  end

  def test_average_response
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal 92, source.average_response("http://jumpstartlab.com/blog")
  end

  def test_http_verbs
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal ["GET", "POST"], source.http_verbs("http://jumpstartlab.com/blog")
  end

  def test_top_referrers
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal [["http://google.com", 2], ["http://turing.io", 1]], source.top_referrers("http://jumpstartlab.com/blog")
  end

  def test_top_browsers
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal ["Chrome", "Internet Explorer"], source.top_browsers("http://jumpstartlab.com/blog").map{|key, value| key}
  end

  def test_top_os
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal ["OS X 10.8.2", "Windows 7"], source.top_os("http://jumpstartlab.com/blog").map {|x,y|x }
  end
end
