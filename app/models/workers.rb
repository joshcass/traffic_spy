module TrafficSpy
  module Workers
    def self.urls(identifier)
      source = TrafficSpy::Source.find_by(identifier: identifier)
      payloads = TrafficSpy::Payload.where(source_id: source.id)
      payloads.group(:url).count.sort.reverse
    end
  end
end
