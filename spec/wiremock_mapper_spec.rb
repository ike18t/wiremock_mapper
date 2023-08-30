require 'spec_helper'

describe WireMockMapper do
  before(:each) do
    WireMockMapper::Configuration.reset_global_mappings
    WireMockMapper::Configuration.set_wiremock_headers({})
  end

  describe 'create_mapping' do
    it 'posts the correct json to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'urlPath' => '/some/path',
                                           'headers' => { 'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body', 'transformers' => ['response-template'] } }

      stub = stub_request(:post, "#{url}/__admin/mappings").with(body: expected_request_body)
                                                           .to_return(body: { id: 'whatevs' }.to_json)

      WireMockMapper.create_mapping(url) do |request, respond|
        request.is_a_post
               .with_url_path.equal_to('/some/path')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
               .with_transformer('response-template')
      end

      expect(stub).to have_been_requested
    end

    it 'posts custom header to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'url' => '/some/url',
                                           'headers' => { 'some_global_header' => { 'equalTo' => 'global value' },
                                                          'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' } }

      stub = stub_request(:post, "#{url}/__admin/mappings").with(body: expected_request_body)
                                                           .to_return(body: { id: 'whatevs' }.to_json)

      WireMockMapper::Configuration.create_global_mapping do |request|
        request.with_header('some_global_header').equal_to('global value')
      end

      WireMockMapper::Configuration.set_wiremock_headers({ 'header1' => 'header-value1' })

      WireMockMapper.create_mapping(url) do |request, respond|
        request.is_a_post
               .with_url.equal_to('/some/url')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')
        respond.with_body('some response body')
      end

      expect(stub).to have_requested(:post, "#{url}/__admin/mappings").with(headers: { 'header1' => 'header-value1' })
    end

    it 'posts the correct json with configured global mappings to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'url' => '/some/url',
                                           'headers' => { 'some_global_header' => { 'equalTo' => 'global value' },
                                                          'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' } }

      stub = stub_request(:post, "#{url}/__admin/mappings").with(body: expected_request_body)
                                                           .to_return(body: { id: 'whatevs' }.to_json)

      WireMockMapper::Configuration.create_global_mapping do |request|
        request.with_header('some_global_header').equal_to('global value')
      end

      WireMockMapper.create_mapping(url) do |request, respond|
        request.is_a_post
               .with_url.equal_to('/some/url')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
      end

      expect(stub).to have_been_requested
    end
  end

  describe 'create_mapping_with_priority' do
    it 'posts the correct json to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'urlPath' => '/some/path',
                                           'headers' => { 'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' },
                                priority: 2 }

      stub = stub_request(:post, "#{url}/__admin/mappings").with(body: expected_request_body)
                                                           .to_return(body: { id: 'whatevs' }.to_json)

      WireMockMapper.create_mapping_with_priority(2, url) do |request, respond|
        request.is_a_post
               .with_url_path.equal_to('/some/path')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
      end

      expect(stub).to have_been_requested
    end

    it 'posts the correct json with configured global mappings to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'url' => '/some/url',
                                           'headers' => { 'some_global_header' => { 'equalTo' => 'global value' },
                                                          'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' },
                                priority: 1 }

      stub = stub_request(:post, "#{url}/__admin/mappings").with(body: expected_request_body)
                                                           .to_return(body: { id: 'whatevs' }.to_json)

      WireMockMapper::Configuration.create_global_mapping do |request|
        request.with_header('some_global_header').equal_to('global value')
      end

      WireMockMapper.create_mapping_with_priority(1, url) do |request, respond|
        request.is_a_post
               .with_url.equal_to('/some/url')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')
        respond.with_body('some response body')
      end

      expect(stub).to have_been_requested
    end
  end

  describe 'delete_mapping' do
    it 'issues a DELETE for the supplied mapping id' do
      mapping_id = 'james-james-james'
      url = 'http://nowhere.com'
      stub = stub_request(:delete, "#{url}/__admin/mappings/#{mapping_id}")
      WireMockMapper.delete_mapping(mapping_id, url)

      expect(stub).to have_been_requested
    end

    it 'issues a DELETE with custom headers for the supplied mapping id' do
      mapping_id = 'james-james-james'
      url = 'http://nowhere.com'
      stub = stub_request(:delete, "#{url}/__admin/mappings/#{mapping_id}")

      WireMockMapper::Configuration.set_wiremock_headers({ 'header2' => 'header-value2' })

      WireMockMapper.delete_mapping(mapping_id, url)

      expect(stub).to have_requested(:delete, "#{url}/__admin/mappings/#{mapping_id}")
        .with(headers: { 'header2' => 'header-value2' })
    end
  end

  describe 'clear_mappings' do
    it 'POSTS to the wiremock __admin/mappings/reset path' do
      url = 'http://nowhere.com'
      stub = stub_request(:post, "#{url}/__admin/mappings/reset")
      WireMockMapper.clear_mappings(url)

      expect(stub).to have_been_requested
    end

    it 'POSTS with custom headers to the wiremock __admin/mappings/reset path' do
      url = 'http://nowhere.com'
      stub = stub_request(:post, "#{url}/__admin/mappings/reset")

      WireMockMapper::Configuration.set_wiremock_headers({ 'header3' => 'header-value3' })

      WireMockMapper.clear_mappings(url)

      expect(stub).to have_requested(:post,
                                     "#{url}/__admin/mappings/reset").with(headers: { 'header3' => 'header-value3' })
    end
  end

  describe 'reset_scenarios' do
    it 'POSTS to the wiremock __admin/scenarios/reset path' do
      url = 'http://nowhere.com'
      stub = stub_request(:post, "#{url}/__admin/scenarios/reset")
      WireMockMapper.reset_scenarios(url)

      expect(stub).to have_been_requested
    end

    it 'POSTS with custom headers to the wiremock __admin/scenarios/reset path' do
      url = 'http://nowhere.com'
      stub = stub_request(:post, "#{url}/__admin/scenarios/reset")

      WireMockMapper::Configuration.set_wiremock_headers({ 'header3' => 'header-value3' })

      WireMockMapper.reset_scenarios(url)

      expect(stub).to have_requested(:post,
                                     "#{url}/__admin/scenarios/reset").with(headers: { 'header3' => 'header-value3' })
    end
  end
end
