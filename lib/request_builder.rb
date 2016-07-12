module WireMockMapper
  class RequestBuilder
    def initialize(configuration = nil)
      @options = {}
      @options['headers'] ||= {}
      @options['headers'] = configuration.request_headers if configuration
    end

    def posts_to_path(url)
      @options['method'] = 'POST'
      @options['urlPath'] = url
      self
    end

    def with_header(key, value)
      @options['headers'][key] = { equalTo: value }
      self
    end

    def with_body(value)
      @options['bodyPatterns'] ||= []
      value = value.to_json unless value.is_a? String
      @options['bodyPatterns'] << { matches: value }
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
