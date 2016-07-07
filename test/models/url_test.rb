require_relative '../test_helper'

class UrlTest < Minitest::Test
  include TestHelpers
  
  def test_ip_address_has_payloads
    create_payload

    assert_equal "http://jumpstartlab.com", Url.all.first.root_url
    assert_equal "/blog", Url.all.first.path
  end
  
  def test_most_requested_to_least_requested
    2.times do
      create_payload
    end
    create_multiple_payloads(3)

    assert_equal "http://jumpstartlab.com/blog", Url.most_requested_to_least_requested.keys.first
    assert_equal 2, Url.most_requested_to_least_requested.values.first
  end
    
end
