require 'net/http'

module SensorsAnalytics
  class Http
    def initialize(server_url)
      @server_url = server_url
    end

    def request(form_data, headers = {})
      init_header = {"User-Agent" => "SensorsAnalytics Ruby SDK"}
      headers.each do |key, value|
        init_header[key] = value
      end

      uri = _get_uri(@server_url)
      request = Net::HTTP::Post.new(uri.request_uri, initheader)
      request.set_form_data(form_data)

      client = Net::HTTP.new(uri.host, uri.port)
      client.open_timeout = 10
      client.continue_timeout = 10
      client.read_timeout = 10

      response = client.request(request)
      [response.code, response.body]
    end

    private

    def _get_uri(url)
      begin
        URI.parse(url)
      rescue URI::InvalidURIError
        host = url.match(".+\:\/\/([^\/]+)")[1]
        uri = URI.parse(url.sub(host, 'dummy-host'))
        uri.instance_variable_set('@host', host)
        uri
      end
    end
  end
end