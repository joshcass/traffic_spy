class TrafficSpy::Source < ActiveRecord::Base
  validates :identifier, :root_url, presence:  true
  validates :identifier, :root_url, uniqueness: true
  has_many :payloads

  def most_visited_urls
    payloads.group(:url).count.sort.reverse
  end

  def average_response_times
    payloads.group(:url).average(:responded_in).sort
  end

  def user_agents
    payloads.pluck(:user_agent).map { |agent| UserAgent.parse(agent) }
  end

  def browser_breakdown
    user_agents.each_with_object(Hash.new(0)) { |agent, counts| counts[agent.browser] += 1 }
  end

  def os_breakdown
    user_agents.each_with_object(Hash.new(0)) { |agent, counts| counts[agent.os] += 1 }
  end

  def screen_res_breakdown
    payloads.group(:resolution_width, :resolution_height).count
  end
end
