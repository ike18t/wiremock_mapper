module WireMockMapper
  class Configuration
    @request_headers = {}
    @wiremock_url = ''

    class << self
      attr_reader :request_headers, :wiremock_url


      # Add a request header for all future requests
      # @param key [String] header key
      # @return [MatchBuilder] match builder to declare the match on the header
      def add_request_header(key)
        @request_headers[key] = MatchBuilder.new(self)
      end

      # Set the WireMock url
      # @param url [String] the url of the WireMock server
      def set_wiremock_url(url)
        @wiremock_url = url
      end
    end
  end
end
