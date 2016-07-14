require_relative 'request_builder'
require_relative 'response_builder'

module WireMockMapper
  class Configuration
    @wiremock_url = ''

    @request_builder = RequestBuilder.new
    @response_builder = ResponseBuilder.new

    class << self
      attr_reader :request_builder, :response_builder, :wiremock_url

      # Add mappings to include for all future mappings
      def create_global_mapping
        yield @request_builder, @response_builder
      end

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
