class TrafficSpy::Source < ActiveRecord::Base
  validates :identifier, :root_url, presence: true
  validates :identifier, :root_url, uniqueness: true
end
