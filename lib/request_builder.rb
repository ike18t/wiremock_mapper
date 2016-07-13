require_relative 'match_builder'
require_relative 'url_match_builder'

module WireMockMapper
  class RequestBuilder
    def initialize(configuration = nil)
      @options = {}
      @options[:headers] = configuration.request_headers if configuration
    end

    HttpVerbs = %w(ANY DELETE GET HEAD OPTIONS POST PUT TRACE).freeze
    HttpVerbs.each do |verb|
      define_method("receives_#{verb.downcase}") do
        @options[:method] = verb
        self
      end
    end

    def with_basic_auth(username, password)
      @options[:basicAuth] = { username: username, password: password }
      self
    end

    def with_body
      @options[:bodyPatterns] ||= []
      match_builder = MatchBuilder.new(self)
      @options[:bodyPatterns] << match_builder
      match_builder
    end

    def with_cookie(key)
      @options[:cookies] ||= {}
      @options[:cookies][key] = MatchBuilder.new(self)
    end

    def with_header(key)
      @options[:headers] ||= {}
      @options[:headers][key] = MatchBuilder.new(self)
    end

    def with_query_params(key)
      @options[:queryParameters] ||= {}
      @options[:queryParameters][key] = MatchBuilder.new(self)
    end

    def with_url
      @url_match = UrlMatchBuilder.new(self)
    end

    def with_url_path
      @url_match = UrlMatchBuilder.new(self, true)
    end

    def to_hash(*)
      options_with_url_match = @options.merge(@url_match.to_hash) if @url_match
      options_with_url_match || @options
    end

    def to_json(*)
      to_hash.to_json
    end
  end
end
