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
        request.posts_to_path('/some/path')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
      end
    end
  end
end
