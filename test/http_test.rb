require 'test_helper'

class HttpTest < Minitest::Test
  def test_http
    http = SensorsAnalytics::Http.new('http://localhost:8080/posts',
      keep_alive: false)
    http.request({"data" => "12345"}, {})
    http.request({"data" => "abcde"}, {})
  end

  def test_http_with_keepalive
    http = SensorsAnalytics::Http.new('http://localhost:8080/posts',
      keep_alive: true)
    http.request({"data" => "12345"}, {})
    http.request({"data" => "abcde"}, {})
  end
end
