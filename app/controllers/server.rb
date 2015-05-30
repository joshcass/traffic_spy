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

    get '/sources/:identifier/urls/*' do |identifier, splat|
      @source = TrafficSpy::Source.find_by(identifier: identifier)
      @path = "#{@source.root_url}/#{splat}"
      if @source.longest_response(@path).nil?
        @every_error = "This URL is lonely, so lonely, because it has never been requested."

        erb :every_error
      else
        @longest_response  = @source.longest_response(@path)
        @shortest_response = @source.shortest_response(@path)
        @average_response  = @source.average_response(@path)
        @http_verbs        = @source.http_verbs(@path)
        @top_referrers     = @source.top_referrers(@path)
        @top_browsers      = @source.top_browsers(@path)
        @top_os            = @source.top_os(@path)

        erb :url_statistics
      end
    end

    get '/sources/:identifier/events' do |identifier|
      @source = TrafficSpy::Source.find_by(identifier: identifier)
      if @source.event_names.count == 0
        @every_error = "Why you no have event?"

        erb :every_error
      else
        @event_names = @source.event_names

        erb :events_index
      end
    end

    not_found do
      erb :error
    end
  end
end
