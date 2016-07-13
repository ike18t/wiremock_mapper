module WireMockMapper
  class ResponseBuilder
    def initialize
      @options = {}
    end

    def with_body(value)
      value = value.to_json unless value.is_a? String
      @options[:body] = value
      self
    end

    def with_header(key, value)
      @options[:headers] ||= {}
      @options[:headers][key] = value
      self
    end

    def with_status(status_code)
      @options[:status] = status_code
      self
    end

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
