ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require

require File.expand_path("../../config/environment", __FILE__)
require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'rack/test'
require 'database_cleaner'
require 'pry'

Capybara.app = RushHour::Server

DatabaseCleaner.strategy = :truncation

module TestHelpers
  include Rack::Test::Methods

  def app
    RushHour::Server
  end

  def setup
    DatabaseCleaner.start
    super
  end

  def teardown
    DatabaseCleaner.clean
    super
  end

  def dummy_payload(type, id, number=1, dummy=35)
    number.times do
      PayloadRequest.create({url_id: 1, requested_at: rand(100), responded_in: dummy += 1,
                            request_type_id: 1, referrer_id: 1, user_agent_id: 1, 
                            resolution_id: 1, ip_address_id: 2}.merge(type => id))
    end
  end
end
