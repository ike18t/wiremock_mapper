require_relative 'match_builder'

module WireMockMapper
  class RequestBuilder
    def initialize(configuration = nil)
      @options = {}
      @options['headers'] = configuration.request_headers if configuration
    end

    def posts_to_path(url)
      @options['method'] = 'POST'
      @options['urlPath'] = url
      self
    end

    def with_basic_auth username, password
      @options['basicAuth'] = { 'username' => username, 'password' => password }
      self
    end

    def with_body
      @options['bodyPatterns'] ||= []
      match_builder = MatchBuilder.new(self)
      @options['bodyPatterns'] << match_builder
      match_builder
    end

    def with_cookie(key)
      @options['cookies'] ||= {}
      @options['cookies'][key] = MatchBuilder.new(self)
    end

    def with_header(key)
      @options['headers'] ||= {}
      @options['headers'][key] = MatchBuilder.new(self)
    end

    def with_query_params(key)
      @options['queryParameters'] ||= {}
      @options['queryParameters'][key] = MatchBuilder.new(self)
    end

    def to_hash(*)
      @options
    end

    def to_json(*)
      @options.to_json
    end
  end
end
