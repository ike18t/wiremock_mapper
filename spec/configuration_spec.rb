require 'spec_helper'

describe WireMockMapper::Configuration do
  context 'request_header' do
    it 'adds the request header' do
      WireMockMapper::Configuration.add_request_header('some', 'header')
      expect(WireMockMapper::Configuration.request_headers).to eq('some' => 'header')
    end
  end

  context 'wiremock_url' do
    it 'sets the wiremock url' do
      WireMockMapper::Configuration.set_wiremock_url('http://whereever.com')
      expect(WireMockMapper::Configuration.wiremock_url).to eq('http://whereever.com')
    end
  end
end
