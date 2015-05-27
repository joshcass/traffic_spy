require_relative '../test_helper'

class RegisterTest < ControllerTest
  def test_it_registers_a_source
    initial_count = TrafficSpy::Source.count

    post '/sources', { identifier: "turing", rootUrl:"http://turing.io"}

    final_count = TrafficSpy::Source.count

    assert_equal 200, last_response.status
    assert_equal "It's all good", last_response.body
    assert_equal 1, (final_count - initial_count)
  end
end
