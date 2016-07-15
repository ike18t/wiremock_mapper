module WireMockMapper
  module Builders
    class MatchBuilder
      def initialize(request_builder)
        @request_builder = request_builder
        @type = ''
        @value = ''
        @options = {}
      end

      # Match if attribute is absent
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def absent
        @type = :absent
        @value = true
        @request_builder
      end

      # Match if attribute value contains the arg
      # @param value [String] string to match
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def containing(value)
        @type = :contains
        @value = value
        @request_builder
      end

      # Match if attribute value is equal to the arg
      # @param value [String] string to compare against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def equal_to(value)
        @type = :equalTo
        @value = value
        @request_builder
      end

      # Match if attribute json is equal to the arg
      # @param json [String] json to compare against
      # @param ignore_array_order [true, false] flag to ignore the order of arrays
      # @param ignore_extra_elements [true, false] flag to ignore any extra elements
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def equal_to_json(json, ignore_array_order = false, ignore_extra_elements = false)
        @type = :equalToJson
        @value = json

        @options[:ignoreArrayOrder] = true if ignore_array_order
        @options[:ignoreExtraElements] = true if ignore_extra_elements

        @request_builder
      end

      # Match if attribute xml is equal to the arg
      # @param xml [String] xml to compare against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def equal_to_xml(xml)
        @type = :equalToXml
        @value = xml
        @request_builder
      end

      # Match if attribute value matches the regex_string
      # @param regex_string [String] xml to match against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def matching(regex_string)
        @type = :matches
        @value = regex_string
        @request_builder
      end

      # Match if attribute json matches the json_path
      # @param json_path [String] json_path to match against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def matching_json_path(json_path)
        @type = :matchesJsonPath
        @value = json_path
        @request_builder
      end

      # Match if attribute xml matches the xpath
      # @param xpath [String] xpath to match against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def matching_xpath(xpath)
        @type = :matchesXPath
        @value = xpath
        @request_builder
      end

      # Match if attribute value does not match
      # @param regex_string [String] regex_string to match against
      # @return [RequestBuilder] calling request builder for chaining additional attributes
      def not_matching(regex_string)
        @type = :doesNotMatch
        @value = regex_string
        @request_builder
      end

      def to_hash(*)
        { @type => @value }.merge(@options)
      end

      def to_json(*)
        to_hash.to_json
      end
    end
  end
end
