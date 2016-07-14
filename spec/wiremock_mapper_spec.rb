require 'spec_helper'

describe WireMockMapper do
  context 'control' do
    it 'posts the correct json to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'urlPath' => '/some/path',
                                           'headers' => { 'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' } }
      stub_request(:post, "#{url}/__admin/mappings/new").with(body: expected_request_body)

      WireMockMapper.create_mapping(url) do |request, respond|
        request.receives_post
               .with_url_path.equal_to('/some/path')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
      end
    end

    # rubocop:disable Metrics/LineLength
    it 'posts the correct json with configured global mappings to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'urlPath' => '/some/path',
                                           'headers' => { 'some_global_header' => { 'equalTo' => 'some global header value' },
                                                          'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' } }
      stub_request(:post, "#{url}/__admin/mappings/new").with(body: expected_request_body)

      request_builder = WireMockMapper::RequestBuilder.new.with_header('some_global_header').equal_to('some global header value')
      expect(WireMockMapper::Configuration).to receive(:request_builder).and_return(request_builder)

      WireMockMapper.create_mapping(url) do |request, respond|
        request.receives_post
               .with_url_path.equal_to('/some/path')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
      end
    end
    # rubocop:enable Metrics/LineLength
  end
end
