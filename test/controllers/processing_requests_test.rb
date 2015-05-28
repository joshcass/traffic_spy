require_relative '../test_helper'

class ProcessingRequestTest < ControllerTest

  PAYLOAD = {
    url: "http://jumpstartlab.com/blog",
    requestedAt: "2013-02-16 21:38:28 -0700",
    respondedIn: 37,
    referredBy: "http://jumpstartlab.com",
    requestType: "GET",
    eventName: "socialLogin",
    userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
    resolutionWidth: "1920",
    resolutionHeight: "1280",
    ip: "63.29.38.211"
  }.to_json

  def test_missing_payload_returns_400_error
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post 'sources/jumpstartlab/data', payload: ""

    assert_equal 400, last_response.status
    assert_equal "Payload cannot be empty", last_response.body
  end

  def test_request_already_recieved_returns_403_error
    skip
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post '/sources/jumstartlab/data', payload: PAYLOAD

    assert_equal 403, last_response.status
    assert_equal "Payload cannot be empty", last_response.body
  end

  def test_request_for_unregistered_source_returns_403_error
    skip
    post 'sources/jumpstartlab/data', payload: PAYLOAD

    assert_equal 403, last_response.status
    assert_equal "??", last_response.body
  end

  def test_request_with_existing_source_and_unique_payload_returns_200_status
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post 'sources/jumpstartlab/data', payload: PAYLOAD

    assert_equal 200, last_response.status
  end
end
