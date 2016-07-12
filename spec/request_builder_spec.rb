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

  context 'with_header' do
    it 'adds the header' do
      builder = WireMockMapper::RequestBuilder.new
      builder.with_header('some', 'header')
      result = builder.to_hash
      expect(result['headers']).to eq('some' => { equalTo: 'header' })
    end
  end

  context 'with_body' do
    it 'adds the body' do
      builder = WireMockMapper::RequestBuilder.new
      builder.with_body('some body')
      result = builder.to_hash
      expect(result['bodyPatterns']).to eq([{ matches: 'some body' }])
    end

    it 'converts value to_json if it is not a string' do
      builder = WireMockMapper::RequestBuilder.new
      builder.with_body(some: 'hash')
      result = builder.to_hash
      expect(result['bodyPatterns']).to eq([{ matches: '{"some":"hash"}' }])
    end
  end
end
