module TrafficSpy class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = TrafficSpy::SourceCreator.new(params)
      status source.status
      body source.body
    end

    post '/sources/:identifier/data' do |identifier|
      if params[:payload] == "" || params[:payload] == {}
        status 400
        body "Payload cannot be empty"
      elsif TrafficSpy::Source.find_by(identifier: identifier).nil?
        status 403
        body "Identifier does not exist"
      else
        parsed_params = JSON.parse(params[:payload])
        request = TrafficSpy::Payload.new(url: parsed_params["url"],
                                          requested_at: parsed_params["requestedAt"],
                                          responded_in: parsed_params["respondedIn"],
                                          referred_by: parsed_params["referredBy"],
                                          request_type: parsed_params["requestType"],
                                          event_name: parsed_params["eventName"],
                                          user_agent: parsed_params["userAgent"],
                                          resolution_width: parsed_params["resolutionWidth"],
                                          resolution_height: parsed_params["resolutionHeight"],
                                          ip: parsed_params["ip"])

        status 200
        body "Payload successfully received"
      end
    end


    not_found do
      erb :error
    end
  end
end
