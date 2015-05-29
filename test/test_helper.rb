ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara'
require 'database_cleaner'

Capybara.app = TrafficSpy::Server
DatabaseCleaner.strategy = :truncation, {except: %w[public.schema_migrations]}

module Helpers
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

  def create_source(identifier, url)
    TrafficSpy::Source.create(identifier: "#{identifier}", root_url: "#{url}")
  end

  def create_payloads
    TrafficSpy::Payload.create( url: "http://jumpstartlab.com/blog",
                                requested_at: "2013-02-16 21:38:28 -0700",
                                responded_in: 93,
                                referred_by: "http://jumpstartlab.com",
                                request_type: "GET",
                                event_name: "socialLogin",
                                user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                                resolution_width: "1920",
                                resolution_height: "1280",
                                ip: "63.29.38.211",
                                source_id: 1,
                                sha: Digest::SHA1.hexdigest(PAYLOAD))
  TrafficSpy::Payload.create( url: "http://jumpstartlab.com/about",
                              requested_at: "2013-02-16 22:38:28 -0700",
                              responded_in: 35,
                              referred_by: "http://jumpstartlab.com",
                              request_type: "GET",
                              event_name: "contact",
                              user_agent: "Mozilla/5.0 (Windows; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
                              resolution_width: "1920",
                              resolution_height: "1280",
                              ip: "63.29.38.211",
                              source_id: 1,
                              sha: Digest::SHA1.hexdigest("stuff"))
   TrafficSpy::Payload.create( url: "http://jumpstartlab.com/blog",
                               requested_at: "2013-02-16 20:38:28 -0700",
                               responded_in: 91,
                               referred_by: "http://jumpstartlab.com",
                               request_type: "GET",
                               event_name: "socialLogin",
                               user_agent: "Mozilla/5.0 (compatible; MSIE 9.0;Windows NT; Trident/5.0)",
                               resolution_width: "1920",
                               resolution_height: "1280",
                               ip: "63.29.38.211",
                               source_id: 1,
                               sha: Digest::SHA1.hexdigest("thing"))
  end
end

class ControllerTest < Minitest::Test
  include Rack::Test::Methods
  include Helpers

  def app
    TrafficSpy::Server
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end


end

class FeatureTest < Minitest::Test
  include Capybara::DSL
  include Helpers

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end
end
