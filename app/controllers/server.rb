module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = TrafficSpy::SourceCreator.new(params)
      status source.status
      body source.body
    end

    post '/sources/:identifier/data' do |identifier|
      payload = TrafficSpy::PayloadCreator.new(params, identifier)
      status payload.status
      body payload.body
    end

    get '/sources/:identifier' do |identifier|
      @source = TrafficSpy::Source.find_by(identifier: identifier)
      if @source.nil?
        @every_error = "You're in a coma right now. This is a signal telling you to wake up. Also, this identifier does not exist."

        erb :every_error
      else
        @most_visited_urls      = @source.most_visited_urls
        @average_response_times = @source.average_response_times
        @browser_breakdown      = @source.browser_breakdown
        @os_breakdown           = @source.os_breakdown
        @screen_res_breakdown   = @source.screen_res_breakdown

        erb :client_dashboard
      end
    end

    not_found do
      erb :error
    end
  end
end
