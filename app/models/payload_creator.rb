class TrafficSpy::PayloadCreator
  attr_reader :data, :identifier, :status, :body

  def initialize(params, identifier)
    @data = params[:payload]
    @identifier = identifier
    @status = nil
    @body = nil
    validate
  end

  def validate
    if data == "" || data == {}
        @status = 400
        @body = "Payload cannot be empty"
      elsif TrafficSpy::Source.find_by(identifier: identifier).nil?
        @status = 403
        @body = "Identifier does not exist"
      else
        parsed_params = JSON.parse(data)
        request = TrafficSpy::Payload.new(url: parsed_params["url"],
                                          requested_at: parsed_params["requestedAt"],
                                          responded_in: parsed_params["respondedIn"],
                                          referred_by: parsed_params["referredBy"],
                                          request_type: parsed_params["requestType"],
                                          event_name: parsed_params["eventName"],
                                          user_agent: parsed_params["userAgent"],
                                          resolution_width: parsed_params["resolutionWidth"],
                                          resolution_height: parsed_params["resolutionHeight"],
                                          ip: parsed_params["ip"],
                                          source_id: TrafficSpy::Source.find_by(identifier: identifier).id,
                                          sha: Digest::SHA1.hexdigest(data))

        if request.save
          @status =  200
          @body = "Payload successfully received"
        elsif request.errors.values.include?(["has already been taken"])
          @status = 403
          @body = "Payload already exists"
        end
     end
  end
end
