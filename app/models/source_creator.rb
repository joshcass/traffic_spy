class TrafficSpy::SourceCreator

  attr_reader :status, :body, :source

  def initialize(params)
    @source = TrafficSpy::Source.new(identifier: params[:identifier], root_url: params[:rootUrl])
    @status = nil
    @body = nil
    validate
  end

  def validate
    if source.save

      @status = 200
      @body = { identifier: source[:identifier] }.to_json
    elsif source.errors.values.include?(["has already been taken"])
      @status = 403
      @body = source.errors.full_messages.each do |msg|
        msg
      end
    elsif source.errors.values.include?(["can't be blank"])
      @status = 400
      @body = source.errors.full_messages.each do |msg|
        msg
      end
    end
  end
end


