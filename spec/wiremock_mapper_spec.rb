require 'spec_helper'

describe WireMockMapper do
  before(:each) { WireMockMapper.send(:forget_saved_mappings) }
  describe 'create_mapping' do
    it 'posts the correct json to the wiremock url' do
      url = 'http://nowhere.com'
      expected_request_body = { request: { 'method' => 'POST',
                                           'urlPath' => '/some/path',
                                           'headers' => { 'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' } }
      stub_request(:post, "#{url}/__admin/mappings/new").with(body: expected_request_body).to_return(body: '{}')

      WireMockMapper.create_mapping(url) do |request, respond|
        request.is_a_post
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
                                           'url' => '/some/url',
                                           'headers' => { 'some_global_header' => { 'equalTo' => 'some global header value' },
                                                          'some_header' => { 'equalTo' => 'some header value' } },
                                           'bodyPatterns' => [
                                             { 'matches' => 'some request body' }
                                           ] },
                                response: { 'body' => 'some response body' } }
      stub_request(:post, "#{url}/__admin/mappings/new").with(body: expected_request_body).to_return(body: '{}')

      request_builder = WireMockMapper::Builders::RequestBuilder.new.with_header('some_global_header').equal_to('some global header value')
      expect(WireMockMapper::Configuration).to receive(:request_builder).and_return(request_builder)

      WireMockMapper.create_mapping(url) do |request, respond|
        request.is_a_post
               .with_url.equal_to('/some/url')
               .with_header('some_header').equal_to('some header value')
               .with_body.matching('some request body')

        respond.with_body('some response body')
      end
    end
    # rubocop:enable Metrics/LineLength
  end

  describe 'delete_mappings' do
    it 'issues a DELETE for each created mapping' do
      mapping_id = 'james-james-james'
      url = 'http://nowhere.com'
      response_body = { id: mapping_id }.to_json
      mapping_path = "#{url}/__admin/mappings/#{mapping_id}"

      stub_request(:post, "#{url}/__admin/mappings/new").to_return(body: response_body)

      WireMockMapper.create_mapping(url) {}
      stub_request(:delete, mapping_path)
      WireMockMapper.delete_mappings(url)

      assert_requested(:delete, mapping_path)
    end

    it "does not delete the same mappings once they've been deleted" do
      mapping_id = 'james-james-james'
      url = 'http://nowhere.com'
      response_body = { id: mapping_id }.to_json
      mapping_path = "#{url}/__admin/mappings/#{mapping_id}"

      stub_request(:post, "#{url}/__admin/mappings/new").to_return(body: response_body)

      WireMockMapper.create_mapping(url) {}
      stub_request(:delete, mapping_path)
      WireMockMapper.delete_mappings(url)
      WireMockMapper.delete_mappings(url)

      assert_requested(:delete, mapping_path, times: 1)
    end
  end
end
