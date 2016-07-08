module ParamParser

  def camel_to_snake_case(params)
    params.reduce({}) do |result, param|
      result.merge!(param.first.underscore => param.last)
    end
  end

  def payload_parse(params)
    camel_to_snake_case(JSON(params[:payload]))
  end

  def create_payload(params)
    payload = payload_parse(params)

    url         = Url.create(split_url(payload[:url]))
    rtype       = RequestType.create(method_name: "GET")
    resolution  = Resolution.create(width: "1920", height: "1280")
    referrer    = Referrer.create(referrer: "http://jumpstartlab.com")
    user_agent  = UserAgent.create(operating_system: "OSX 10.8.2", browser: "Chrome")
    ip          = IPAddress.create(ip_address: "63.29.38.211")

    PayloadRequest.create(url_id: url.id,
                          requested_at: "abcd",
                          responded_in: "5",
                          referrer_id: referrer.id,
                          request_type_id: rtype.id,
                          user_agent_id: user_agent.id,
                          resolution_id: resolution.id,
                          ip_address_id: ip.id)
  end

  def split_url(url)
    # refactor?
    {:root_url => url.split("/")[0..2].join("/"), :path => "/" + url.split("/").last}
  end
end
