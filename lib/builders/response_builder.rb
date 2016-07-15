module WireMockMapper
  module Builders
    class ResponseBuilder
      def initialize
        @options = {}
      end

      # Response body
      # @param value [String] the value to set the response body to
      # @return [ResponseBuilder] response builder for chaining
      def with_body(value)
        value = value.to_json unless value.is_a? String
        @options[:body] = value
        self
      end

      # Add a response header
      # @param key [String] the key of the header
      # @param value [String] the value of the header
      # @return [ResponseBuilder] response builder for chaining
      def with_header(key, value)
        @options[:headers] ||= {}
        @options[:headers][key] = value
        self
      end

      # Add a response http status
      # @param status_code [String, Numeric] the status code to respond with
      # @return [ResponseBuilder] response builder for chaining
      def with_status(status_code)
        @options[:status] = status_code
        self
      end

      # Add a response http status
      # @param status_code [String] the status message to respond with
      # @return [ResponseBuilder] response builder for chaining
      def with_status_message(status_message)
        @options[:statusMessage] = status_message
        self
      end

      def to_hash(*)
        @options
      end

      def to_json(*)
        @options.to_json
      end
    end
  end
end
