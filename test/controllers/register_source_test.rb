require_relative '../test_helper'

class RegistrationTest < ControllerTest
  def test_it_registers_a_source
    assert_equal 0, TrafficSpy::Source.count

    post '/sources', { identifier: "turing", rootUrl:"http://turing.io" }

    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"turing\"}", last_response.body
    assert_equal 1, TrafficSpy::Source.count
  end

  def test_missing_rootUrl_returns_400_error
    post '/sources', { identifier: "turing", rootUrl: "" }

    assert_equal 400, last_response.status
    assert_equal "Root url can't be blank", last_response.body
  end

  def test_missing_identifier_returns_400_error
    post '/sources', { identifier: "", rootUrl: "www.turing.io" }

    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end

  def test_pre_exsiting_identifier_returns_403_error
    create_source("turing", "www.turing.io")
    post '/sources', { identifier: "turing", rootUrl: "www.turing.com" }

    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end

  def test_pre_existing_rootUrl_returns_403_error
    create_source("turing", "www.turing.io")
    post '/sources', { identifier: "turin", rootUrl: "www.turing.io" }

    assert_equal 403, last_response.status
    assert_equal "Root url has already been taken", last_response.body
  end
end
