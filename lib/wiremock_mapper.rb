require 'net/http'
require_relative 'configuration'

module WireMockMapper
  def self.create_mapping(url = Configuration.wiremock_url)
    request_builder = deep_clone(Configuration.request_builder)
    response_builder = deep_clone(Configuration.response_builder)

    yield request_builder, response_builder

    send_to_wiremock(url, request: request_builder, response: response_builder)
  end

  WIREMOCK_NEW_MAPPING_PATH = '__admin/mappings/new'.freeze
  private_constant :WIREMOCK_NEW_MAPPING_PATH

  def self.deep_clone(object)
    Marshal.load(Marshal.dump(object))
  end
  private_class_method :deep_clone

  def self.send_to_wiremock(url, body)
    uri = URI(URI.join(url, WIREMOCK_NEW_MAPPING_PATH))
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
    request.body = body.to_json
    http.request(request)
  end
  private_class_method :send_to_wiremock
end
