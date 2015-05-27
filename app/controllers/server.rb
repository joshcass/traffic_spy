module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do


      source = TrafficSpy::Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if source.save
        status 200
        body "It's all good"
      else
        status 403
        body "It's not good, at all"
      end
    end


    not_found do
      erb :error
    end
  end
end
