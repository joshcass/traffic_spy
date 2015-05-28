require_relative '../test_helper'

class ProcessingRequestTest < ControllerTest
  def test_missing_payload_returns_400_error
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post 'sources/jumpstartlab/data'

    assert_equal 400, last_response.status
    assert_equal "??", last_response.body
  end

  def test_request_already_recieved_returns_403_error
    create_source("jumpstartlab", "http://jumpstartlab.com")
    # use our payload parsing method to create an existing request for this payload
    post 'sources/jumpstartlab/data', payload = {
        "url":"http://jumpstartlab.com/blog",
        "requestedAt":"2013-02-16 21:38:28 -0700",
        "respondedIn":37,
        "referredBy":"http://jumpstartlab.com",
        "requestType":"GET",
        "parameters":[],
        "eventName": "socialLogin",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"63.29.38.211"
      }

    assert_equal 403, last_response.status
    assert_equal "??", last_response.body
  end

  def test_request_for_unregistered_source_returns_403_error
    post 'sources/jumpstartlab/data', payload = {
        "url":"http://jumpstartlab.com/blog",
        "requestedAt":"2013-02-16 21:38:28 -0700",
        "respondedIn":37,
        "referredBy":"http://jumpstartlab.com",
        "requestType":"GET",
        "parameters":[],
        "eventName": "socialLogin",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"63.29.38.211"
      }

    assert_equal 403, last_response.status
    assert_equal "??", last_response.body
  end

  def test_request_with_existing_source_and_unique_payload_returns_200_status
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post 'sources/jumpstartlab/data', payload = {
        "url":"http://jumpstartlab.com/blog",
        "requestedAt":"2013-02-16 21:38:28 -0700",
        "respondedIn":37,
        "referredBy":"http://jumpstartlab.com",
        "requestType":"GET",
        "parameters":[],
        "eventName": "socialLogin",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"63.29.38.211"
      }

    assert_equal 200, last_response.status
  end
end
