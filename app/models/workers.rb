module TrafficSpy
  module Workers
    def self.most_visited_urls(identifier)
      source = TrafficSpy::Source.find_by(identifier: identifier)
      payloads = TrafficSpy::Payload.where(source_id: source.id)
      payloads.group(:url).count.sort.reverse
    end

    def self.avg_response_times(identifier)
      source = TrafficSpy::Source.find_by(identifier: identifier)
      payloads = TrafficSpy::Payload.where(source_id: source.id)
      payloads.group(:url).average(:responded_in).sort
    end
  end
end
