require 'net/http'
require_relative 'configuration'
require_relative 'request_builder'
require_relative 'response_builder'

module WireMockMapper
  VERSION = '0.1.0'.freeze

  def self.create_mapping(url = Configuration.wiremock_url)
    request_builder = RequestBuilder.new
    response_builder = ResponseBuilder.new

    yield request_builder, response_builder

    send(url, request: request_builder, response: response_builder)
  end

  WIREMOCK_NEW_MAPPING_PATH = '__admin/mappings/new'.freeze
  private_constant :WIREMOCK_NEW_MAPPING_PATH

  def self.send(url, body)
    uri = URI(URI.join(url, WIREMOCK_NEW_MAPPING_PATH))
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = body.to_json
    http.request(request)
  end
  private_class_method :send
end
