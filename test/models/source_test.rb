require_relative '../test_helper'

class SourceTest < ModelTest
  def test_most_visited_urls
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal [["http://jumpstartlab.com/blog", 3], ["http://jumpstartlab.com/about", 1]], source.most_visited_urls
  end
end
