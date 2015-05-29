require_relative '../test_helper'

class ProcessingRequestTest < ControllerTest


  def test_missing_payload_returns_400_error
    skip
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post 'sources/jumpstartlab/data', payload: ""

    assert_equal 400, last_response.status
    assert_equal "Payload cannot be empty", last_response.body
  end

  def test_request_already_recieved_returns_403_error
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post '/sources/jumpstartlab/data', payload: PAYLOAD
    post '/sources/jumpstartlab/data', payload: PAYLOAD

    assert_equal 403, last_response.status
    assert_equal "Payload already exists", last_response.body
  end

  def test_request_for_unregistered_source_returns_403_error
    post 'sources/jumpstartlab/data', payload: PAYLOAD

    assert_equal 403, last_response.status
    assert_equal "Identifier does not exist", last_response.body
  end

  def test_request_with_existing_source_and_unique_payload_returns_200_status
    create_source("jumpstartlab", "http://jumpstartlab.com")
    post 'sources/jumpstartlab/data', payload: PAYLOAD

    assert_equal 200, last_response.status
    assert_equal "Payload successfully received", last_response.body
  end
end
