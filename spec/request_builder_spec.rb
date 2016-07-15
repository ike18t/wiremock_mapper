require 'spec_helper'

describe WireMockMapper::Builders::RequestBuilder do
  let(:builder) { WireMockMapper::Builders::RequestBuilder.new }

  describe 'receives_any' do
    it 'sets the http method and url path' do
      builder.receives_any
      result = builder.to_hash
      expect(result[:method]).to eq('ANY')
    end
  end

  describe 'receives_delete' do
    it 'sets the http method and url path' do
      builder.receives_delete
      result = builder.to_hash
      expect(result[:method]).to eq('DELETE')
    end
  end

  describe 'receives_get' do
    it 'sets the http method and url path' do
      builder.receives_get
      result = builder.to_hash
      expect(result[:method]).to eq('GET')
    end
  end

  describe 'receives_head' do
    it 'sets the http method and url path' do
      builder.receives_head
      result = builder.to_hash
      expect(result[:method]).to eq('HEAD')
    end
  end

  describe 'receives_options' do
    it 'sets the http method and url path' do
      builder.receives_options
      result = builder.to_hash
      expect(result[:method]).to eq('OPTIONS')
    end
  end

  describe 'receives_put' do
    it 'sets the http method and url path' do
      builder.receives_put
      result = builder.to_hash
      expect(result[:method]).to eq('PUT')
    end
  end

  describe 'receives_post' do
    it 'sets the http method and url path' do
      builder.receives_post
      result = builder.to_hash
      expect(result[:method]).to eq('POST')
    end
  end

  describe 'receives_trace' do
    it 'sets the http method and url path' do
      builder.receives_trace
      result = builder.to_hash
      expect(result[:method]).to eq('TRACE')
    end
  end

  describe 'with_basic_auth' do
    it 'adds basic auth' do
      builder.with_basic_auth('ike', '123456')
      expect(builder.to_hash[:basicAuth]).to eq(username: 'ike', password: '123456')
    end
  end

  describe 'with_body' do
    it 'returns a MatchBuilder' do
      expect(builder.with_body).to be_a(WireMockMapper::Builders::MatchBuilder)
    end

    it 'adds the matcher to bodyPatterns' do
      matcher = builder.with_body
      expect(builder.to_hash).to eq(bodyPatterns: [matcher])
    end
  end

  describe 'with_cookie' do
    it 'returns a MatchBuilder' do
      expect(builder.with_cookie(:whatever)).to be_a(WireMockMapper::Builders::MatchBuilder)
    end
  end

  describe 'with_header' do
    it 'returns a MatchBuilder' do
      expect(builder.with_header(:whatever)).to be_a(WireMockMapper::Builders::MatchBuilder)
    end
  end

  describe 'with_url' do
    it 'should return a UrlMatchBuilder' do
      expect(builder.with_url).to be_a(WireMockMapper::Builders::UrlMatchBuilder)
    end
  end

  describe 'with_url_path' do
    it 'should return a UrlMatchBuilder' do
      expect(builder.with_url_path).to be_a(WireMockMapper::Builders::UrlMatchBuilder)
    end
  end

  describe 'to_hash' do
    it 'should merge in url_match info' do
      builder.with_url.equal_to('foo')
      expect(builder.to_hash).to eq(url: 'foo')
    end
  end

  describe 'with_query_param' do
    it 'returns a MatchBuilder' do
      expect(builder.with_query_param(:whatever)).to be_a(WireMockMapper::Builders::MatchBuilder)
    end
  end
end
