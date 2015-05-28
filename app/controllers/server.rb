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
      request = TrafficSpy::Payload.new(url: params[:url],
                                        requested_at: params[:requestedAt],
                                       responded_in: params[:respondedIn],
                                       referred_by: params[:referredBy],
                                       request_type: params[:requestType],
                                       event_name: params[:eventName],
                                       user_agent: params[:userAgent],
                                       resolution_width: params[:resolutionWidth],
                                       ip: params[:ip])

    end


    not_found do
      erb :error
    end
  end
end
