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
      @most_visited_urls = TrafficSpy::Workers.most_visited_urls(identifier)
      @avg_response_times = TrafficSpy::Workers.avg_response_times(identifier)
      erb :client_dashboard
    end

    not_found do
      erb :error
    end
  end
end
