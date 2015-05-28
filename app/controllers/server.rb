module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    post '/sources' do
      source = TrafficSpy::Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
      if source.save
        status 200
        {:identifier => source[:identifier]}.to_json
      elsif source.errors.full_messages.first.include?("has already been taken")
        status 403
        source.errors.full_messages.each do |msg|
          body msg
        end
      elsif source.errors.full_messages.first.include?("can't be blank")
        status 400
        source.errors.full_messages.each do |msg|
          body msg
        end
      end
    end

    not_found do
      erb :error
    end
  end
end
