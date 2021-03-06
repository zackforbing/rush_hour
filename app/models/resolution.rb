class Resolution < ActiveRecord::Base
  has_many  :payload_requests
  has_many  :ip_addresses,  through: :payload_requests
  has_many  :referrers,     through: :payload_requests
  has_many  :request_types, through: :payload_requests
  has_many  :urls,          through: :payload_requests
  has_many  :user_agents,   through: :payload_requests

  validates :width,   presence: true, uniqueness: {:scope => :height}
  validates :height,  presence: true, uniqueness: {:scope => :width}
end
