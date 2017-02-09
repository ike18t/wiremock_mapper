require 'spec_helper'

describe WireMockMapper::Builders::ResponseBuilder do
  let(:builder) { WireMockMapper::Builders::ResponseBuilder.new }

  describe 'with_body' do
    it 'adds the body' do
      builder.with_body('some body')
      result = builder.to_hash
      expect(result[:body]).to eq('some body')
    end

    it 'converts value to_json if it is not a string' do
      builder.with_body(some: 'hash')
      result = builder.to_hash
      expect(result[:body]).to eq('{"some":"hash"}')
    end
  end

  describe 'with_header' do
    it 'adds the header' do
      builder.with_header('key', 'value')
      result = builder.to_hash
      expect(result[:headers]).to eq('key' => 'value')
    end

    it 'adds multiple headers' do
      builder.with_header('key', 'value')
      builder.with_header('another key', 'another value')
      result = builder.to_hash
      expect(result[:headers]).to eq('key' => 'value', 'another key' => 'another value')
    end
  end

  describe 'with_status' do
    it 'adds the status code' do
      builder.with_status(400)
      result = builder.to_hash
      expect(result[:status]).to eq(400)
    end
  end

  describe 'with_status_message' do
    it 'adds the status message' do
      builder.with_status_message('message')
      result = builder.to_hash
      expect(result[:statusMessage]).to eq('message')
    end
  end

  describe 'with_delay' do
    it 'adds the fixed delay milliseconds' do
      builder.with_delay(1200)
      result = builder.to_hash
      expect(result[:fixedDelayMilliseconds]).to eq(1200)
    end
  end

  describe 'with_transformer' do
    it 'adds the transformer for wiremock to use' do
      builder.with_transformer('optimus prime')
      result = builder.to_hash
      expect(result[:transformer]).to eq('optimus prime')
    end
  end
end
