module WireMockMapper
  class Configuration
    @request_headers = {}
    @wiremock_url = ''

    class << self
      attr_reader :request_headers, :wiremock_url

      def add_request_header(key, value)
        @request_headers[key] = value
      end

      def set_wiremock_url(url)
        @wiremock_url = url
      end
    end
  end
end
