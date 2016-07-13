module WireMockMapper
  class MatchBuilder
    def initialize(request_builder)
      @request_builder = request_builder
      @type = ''
      @value = ''
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

    def equal_to_json(json)
      @type = :equalToJson
      @value = json
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
      { @type => @value }
    end

    def to_json(*)
      to_hash.to_json
    end
  end
end
