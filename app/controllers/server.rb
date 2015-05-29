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
      @most_visited_urls = @source.most_visited_urls
      @average_response_times = @source.average_response_times

      erb :client_dashboard
    end

    not_found do
      erb :error
    end
  end
end
