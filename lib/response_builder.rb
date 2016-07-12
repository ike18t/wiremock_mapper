module WireMockMapper
  class ResponseBuilder
    def initialize
      @options = {}
    end

    def with_body(value)
      value = value.to_json unless value.is_a? String
      @options['body'] = value
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
