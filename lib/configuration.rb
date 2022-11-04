require_relative 'builders/request_builder'
require_relative 'builders/response_builder'
require_relative 'builders/scenario_builder'

module WireMockMapper
  class Configuration
    @wiremock_url = ''
    @wiremock_headers = {}

    @request_builder = Builders::RequestBuilder.new
    @response_builder = Builders::ResponseBuilder.new
    @scenario_builder = Builders::ScenarioBuilder.new

    class << self
      attr_reader :request_builder, :response_builder, :wiremock_url, :wiremock_headers, :scenario_builder

      # Add mappings to include for all future mappings
      def create_global_mapping
        yield @request_builder, @response_builder, @scenario_builder
      end

      def reset_global_mappings
        @request_builder = Builders::RequestBuilder.new
        @response_builder = Builders::ResponseBuilder.new
        @scenario_builder = Builders::ScenarioBuilder.new
      end

      # Set the WireMock url
      # @param url [String] the url of the WireMock server
      def set_wiremock_url(url)
        @wiremock_url = url
      end

      # Set the WireMock headers
      # @param headers [hash] all the header that we need to set for wiremock
      def set_wiremock_headers(headers)
        @wiremock_headers = headers
      end
    end
  end
end
