require 'spec_helper'
require_relative '../lib/url_match_builder'

describe WireMockMapper::MatchBuilder do
  context 'initialized with path = true' do
    let(:builder) { WireMockMapper::UrlMatchBuilder.new(nil, true) }

    describe 'equal_to' do
      it 'sets the return of to_hash to {urlPath: value}' do
        builder.equal_to '/some/path'
        expect(builder.to_hash).to eq(urlPath: '/some/path')
      end
    end

    describe 'matching' do
      it 'sets the return of to_hash to {urlPathPattern: value}' do
        builder.matching '/some/path'
        expect(builder.to_hash).to eq(urlPathPattern: '/some/path')
      end
    end
  end

  context 'initialized with path = false' do
    let(:builder) { WireMockMapper::UrlMatchBuilder.new(nil) }

    describe 'equal_to' do
      it 'sets the return of to_hash to {url: value}' do
        builder.equal_to '/some/path'
        expect(builder.to_hash).to eq(url: '/some/path')
      end
    end

    describe 'matching' do
      it 'sets the return of to_hash to {urlPattern: value}' do
        builder.matching '/some/path'
        expect(builder.to_hash).to eq(urlPattern: '/some/path')
      end
    end
  end
end
