require_relative '../test_helper'

class ClientCanSeeAllUrlStatsTest < FeatureTest
  include TestHelpers

  def setup
    url_create("http://jumpstartlab.com", "/")
    request_type_create("GET")
    resolution_create("1920", "1580")
    user_agent_create("OS X 10.8.2", "Chrome")
    referrer_create("www.google.com")
    ip_address_create("102.42.91.123")
  end

  def test_client_can_see_their_statistics
    client = Client.create(root_url: "http://jumpstartlab.com", identifier: "jumpstartlab")
    dummy_payload(:client_id, client.id, 4)

    visit '/sources/jumpstartlab'

    within("#statistics") do
      assert has_content?("Average Response Time")
      assert has_content?("37")
      assert has_content?("Maximum Response Time")
      assert has_content?("39")
      assert has_content?("Minimum Response Time")
      assert has_content?("36")
      assert has_content?("Most Frequent Request Type")
      assert has_content?("GET")
      assert has_content?("All HTTP Verbs")
      assert has_content?("GET")
      assert has_content?("All URLs By Rank")
      assert has_css?("a")
      assert has_content?("Web Browser Breakdown")
      assert has_content?("Chrome")
      assert has_content?("Operating System Breakdown")
      assert has_content?("OS X 10.8.2")
      assert has_content?("Screen Resolution Breakdown")
      assert has_content?("1920 x 1580")
    end
  end
end
