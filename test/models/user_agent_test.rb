require_relative '../test_helper'

class UserAgentTest < Minitest::Test
  include TestHelpers

  def test_user_agent_has_relationship_with_payload_requests
    ua = UserAgent.new

    assert ua.respond_to?(:payload_requests)
  end

  def test_user_agent_has_operating_system_attribute
    ua = UserAgent.new(operating_system: "OS X 10.8.2")

    assert_equal "OS X 10.8.2", ua.operating_system
  end

  def test_user_agent_has_browser_attribute
    ua = UserAgent.new(browser: "Chrome")

    assert_equal "Chrome", ua.browser
  end 

  def test_user_agent_created_with_valid_attributes
    ua = UserAgent.new(operating_system: "OS X 10.8.2", browser: "Chrome")

    assert ua.valid?
  end

  def test_user_agent_is_not_created_with_invalid_attributes
    ua = UserAgent.new(operating_system: "OS X 10.8.2")

    refute ua.valid?
  end

  def test_user_agent_uniqueness
    ua_one = UserAgent.create(operating_system: "OS X 10.8.2", browser: "Chrome")
    ua_two = UserAgent.create(operating_system: "OS X 10.8.2", browser: "Chrome")

    assert ua_one.valid?
    refute ua_two.valid?
    assert_equal 1, UserAgent.count
  end

end
