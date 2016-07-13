require 'spec_helper'

describe WireMockMapper::RequestBuilder do
  context 'posts_to_path' do
    it 'sets the http method and url path' do
      builder = WireMockMapper::RequestBuilder.new
      builder.posts_to_path('/some/path')
      result = builder.to_hash
      expect(result['method']).to eq('POST')
      expect(result['urlPath']).to eq('/some/path')
    end
  end

  describe 'with_body' do
    it 'returns a MatchBuilder' do
      builder = WireMockMapper::RequestBuilder.new
      expect(builder.with_body).to be_a(WireMockMapper::MatchBuilder)
    end

    it 'adds the matcher to bodyPatterns' do
      builder = WireMockMapper::RequestBuilder.new
      matcher = builder.with_body
      expect(builder.to_hash).to eq('bodyPatterns' => [matcher])
    end
  end

  describe 'with_cookie' do
    it 'returns a MatchBuilder' do
      builder = WireMockMapper::RequestBuilder.new
      expect(builder.with_cookie('whatever')).to be_a(WireMockMapper::MatchBuilder)
    end
  end

  describe 'with_header' do
    it 'returns a MatchBuilder' do
      builder = WireMockMapper::RequestBuilder.new
      expect(builder.with_header('whatever')).to be_a(WireMockMapper::MatchBuilder)
    end
  end

  describe 'with_query_params' do
    it 'returns a MatchBuilder' do
      builder = WireMockMapper::RequestBuilder.new
      expect(builder.with_query_params('whatever')).to be_a(WireMockMapper::MatchBuilder)
    end
  end
end
