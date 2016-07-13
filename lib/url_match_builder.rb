module WireMockMapper
  class UrlMatchBuilder
    def initialize(request_builder, path = false)
      @request_builder = request_builder
      @path = path
      @type = ''
      @url_or_pattern = ''
    end

    def equal_to(url)
      @type = @path ? :urlPath : :url
      @url_or_pattern = url
      @request_builder
    end

    def matching(regex_string)
      @type = @path ? :urlPathPattern : :urlPattern
      @url_or_pattern = regex_string
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
