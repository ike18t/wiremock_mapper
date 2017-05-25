require 'net/http'
require_relative 'configuration'

module WireMockMapper
  class << self
    def create_mapping(url = Configuration.wiremock_url)
      request_builder = deep_clone(Configuration.request_builder)
      response_builder = deep_clone(Configuration.response_builder)

      yield request_builder, response_builder

      response = send_to_wiremock(url, request: request_builder, response: response_builder)
      body = JSON.parse(response.body)
      save_mapping_id(body['id'])
      body
    end

    def delete_mappings(url = Configuration.wiremock_url)
      mapping_ids.each do |mapping_id|
        delete_from_wiremock(url, mapping_id)
      end

      forget_saved_mappings
    end

    private

    WIREMOCK_MAPPINGS_PATH = '__admin/mappings'.freeze
    WIREMOCK_NEW_MAPPING_PATH = "#{WIREMOCK_MAPPINGS_PATH}/new".freeze

    def deep_clone(object)
      Marshal.load(Marshal.dump(object))
    end

    def save_mapping_id(mapping_id)
      mapping_ids << mapping_id
    end

    def mapping_ids
      @mapping_ids ||= []
    end

    def forget_saved_mappings
      mapping_ids.clear
    end

    def delete_from_wiremock(url, mapping_id)
      uri = URI([url, WIREMOCK_MAPPINGS_PATH, mapping_id].join('/'))
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Delete.new(uri.path)
      http.request(request)
    end

    def send_to_wiremock(url, body)
      uri = URI([url, WIREMOCK_NEW_MAPPING_PATH].join('/'))
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      request.body = body.to_json
      http.request(request)
    end
  end
end
