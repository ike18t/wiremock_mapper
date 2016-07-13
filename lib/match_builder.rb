module WireMockMapper
  class MatchBuilder
    def initialize(request_builder)
      @request_builder = request_builder
      @type = ''
      @value = ''
      @options = {}
    end

    def absent
      @type = :absent
      @value = true
      @request_builder
    end

    def containing(value)
      @type = :contains
      @value = value
      @request_builder
    end

    def equal_to(value)
      @type = :equalTo
      @value = value
      @request_builder
    end

    def equal_to_json(json, ignore_array_order = false, ignore_extra_elements = false)
      @type = :equalToJson
      @value = json

      @options[:ignoreArrayOrder] = true if ignore_array_order
      @options[:ignoreExtraElements] = true if ignore_extra_elements

      @request_builder
    end

    def equal_to_xml(xml)
      @type = :equalToXml
      @value = xml
      @request_builder
    end

    def matching(regex_string)
      @type = :matches
      @value = regex_string
      @request_builder
    end

    def matching_json_path(json_path)
      @type = :matchesJsonPath
      @value = json_path
      @request_builder
    end

    def matching_xpath(xpath)
      @type = :matchesXPath
      @value = xpath
      @request_builder
    end

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
