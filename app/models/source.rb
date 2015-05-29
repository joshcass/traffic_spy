class TrafficSpy::Source < ActiveRecord::Base
  validates :identifier, :root_url, presence:  true
  validates :identifier, :root_url, uniqueness: true
  has_many :payloads

  def most_visited_urls
    payloads.group(:url).count.sort.reverse
  end
end
