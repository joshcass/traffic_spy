class TrafficSpy::Source < ActiveRecord::Base
  validates :identifier, :root_url, presence:  true
  validates :identifier, :root_url, uniqueness: true
  has_many :payloads

  def most_visited_urls
    payloads.group(:url).count.sort_by {|_,v|v}.reverse
  end

  def average_response_times
    payloads.group(:url).average(:responded_in).sort_by {|_,v|v}.reverse
  end

  def user_agents(path = nil)
    if path
      payloads.where(url: path).pluck(:user_agent).map { |agent| UserAgent.parse(agent) }
    else
      payloads.pluck(:user_agent).map { |agent| UserAgent.parse(agent) }
    end
  end

  def browser_breakdown
    user_agents.each_with_object(Hash.new(0)) { |agent, counts| counts[agent.browser] += 1 }
  end

  def os_breakdown
    user_agents.each_with_object(Hash.new(0)) { |agent, counts| counts[agent.os] += 1 }
  end

  def screen_res_breakdown
    payloads.group(:resolution_width, :resolution_height).count.sort_by{|_,v|v}.reverse
  end

  def longest_response(path)
    payloads.where(url: path).maximum(:responded_in)
  end

  def shortest_response(path)
    payloads.where(url: path).minimum(:responded_in)
  end

  def average_response(path)
    payloads.where(url: path).average(:responded_in)
  end

  def http_verbs(path)
    payloads.where(url: path).pluck(:request_type).uniq
  end

  def top_referrers(path)
    payloads.where(url: path).group(:referred_by).count.sort_by{|_,v|v}.reverse
  end

  def top_browsers(path)
    user_agents(path).each_with_object(Hash.new(0)) { |agent, counts| counts[agent.browser] += 1 }
  end

  def top_os(path)
    user_agents(path).each_with_object(Hash.new(0)) { |agent, counts| counts[agent.os] += 1 }
  end
end
