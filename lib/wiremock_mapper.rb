require 'net/http'
require_relative 'configuration'

module WireMockMapper
  class << self
    def create_mapping(url = Configuration.wiremock_url)
      request_builder = deep_clone(Configuration.request_builder)
      response_builder = deep_clone(Configuration.response_builder)

      yield request_builder, response_builder

      response = send_to_wiremock(url, request: request_builder, response: response_builder)
      JSON.parse(response.body).fetch('id')
    end

    def delete_mapping(mapping_id, url = Configuration.wiremock_url)
      delete_from_wiremock(url, mapping_id)
    end

    def clear_mappings(url = Configuration.wiremock_url)
      clear_wiremock_mappings(url)
    end

    private

    WIREMOCK_MAPPINGS_PATH = '__admin/mappings'.freeze
    WIREMOCK_CLEAR_MAPPINGS_PATH = "#{WIREMOCK_MAPPINGS_PATH}/reset".freeze

    def deep_clone(object)
      Marshal.load(Marshal.dump(object))
    end

    def clear_wiremock_mappings(url)
      uri = URI([url, WIREMOCK_CLEAR_MAPPINGS_PATH].join('/'))
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path)
      http.request(request)
    end

    def delete_from_wiremock(url, mapping_id)
      uri = URI([url, WIREMOCK_MAPPINGS_PATH, mapping_id].join('/'))
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Delete.new(uri.path)
      http.request(request)
    end

    def send_to_wiremock(url, body)
      uri = URI([url, WIREMOCK_MAPPINGS_PATH].join('/'))
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      request.body = body.to_json
      http.request(request)
    end
  end
end
