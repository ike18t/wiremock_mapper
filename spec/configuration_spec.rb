require 'spec_helper'

describe WireMockMapper::Configuration do
  describe 'create_global_mapping' do
    it 'configures the request builder attribute' do
      expect(WireMockMapper::Configuration.request_builder.to_hash).to eq({})

      WireMockMapper::Configuration.create_global_mapping do |request, _response|
        request.with_header('foo').equal_to('bar')
      end

      header_key_value = WireMockMapper::Configuration.request_builder.to_hash[:headers]['foo']
      expect(header_key_value).to be_a(WireMockMapper::Builders::MatchBuilder)

      # BOOOOOO!
      WireMockMapper::Configuration.instance_variable_set(:@request_builder,
                                                          WireMockMapper::Builders::RequestBuilder.new)
    end
  end

  describe 'wiremock_url' do
    it 'sets the wiremock url' do
      WireMockMapper::Configuration.set_wiremock_url('http://whereever.com')
      expect(WireMockMapper::Configuration.wiremock_url).to eq('http://whereever.com')
    end
  end

  describe 'wiremock_headers' do
    it 'sets the wiremock headers' do
      WireMockMapper::Configuration.set_wiremock_headers({ 'Authorization' => 'Bearer ABC123' })
      expect(WireMockMapper::Configuration.wiremock_headers).to eq({ 'Authorization' => 'Bearer ABC123' })
    end
  end
end
