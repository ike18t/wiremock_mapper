require_relative 'helpers'

module WireMockMapper
  module Builders
    class UrlMatchBuilder
      def initialize(request_builder, path = false)
        @request_builder = request_builder
        @path = path
        @type = ''
        @url_or_pattern = ''
      end

      # Expect url to equal
      # @param url [String] url to match against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def equal_to(url)
        @type = @path ? :urlPath : :url
        @url_or_pattern = url
        @request_builder
      end

      # Expect url to match
      # @param regexp [Regexp, String] regex for url to match against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def matching(regexp)
        regexp = Helpers.regexp_to_string regexp if regexp.is_a? Regexp
        @type = @path ? :urlPathPattern : :urlPattern
        @url_or_pattern = regexp
        @request_builder
      end

      def to_hash(*)
        { @type => @url_or_pattern }
      end

      def to_json(*)
        to_hash.to_json
      end
    end
  end
end
