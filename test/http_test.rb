require 'test_helper'

class HttpTest < Minitest::Test

  def test_http
    response = stub(code: 200, body: "ok")
    Net::HTTP.any_instance.stubs(:request).returns(response)

    http = SensorsAnalytics::Http.new('http://localhost:8080/posts',
      keep_alive: false)
    http.request({"data" => "12345"}, {})
    http.request({"data" => "abcde"}, {})
  end

  def test_http_with_keepalive
    response = stub(code: 200, body: "ok")
    Net::HTTP::Persistent.any_instance.stubs(:request).returns(response)

    http = SensorsAnalytics::Http.new('http://localhost:8080/posts',
      keep_alive: true)
    http.request({"data" => "12345"}, {})
    http.request({"data" => "abcde"}, {})
  end
end
