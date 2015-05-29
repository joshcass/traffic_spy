class TrafficSpy::Payload < ActiveRecord::Base
  validates :sha, uniqueness: true
  belongs_to :source
end
