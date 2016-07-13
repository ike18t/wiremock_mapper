require 'spec_helper'

describe WireMockMapper::MatchBuilder do
  describe 'absent' do
    it 'returns a hash of { absent => true }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.absent
      expect(builder.to_hash).to eq(absent: true)
    end
  end

  describe 'containing' do
    it 'returns a hash of { contains => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.containing 'foo'
      expect(builder.to_hash).to eq(contains: 'foo')
    end
  end

  describe 'equal_to' do
    it 'returns a hash of { equalTo => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.equal_to 'foo'
      expect(builder.to_hash).to eq(equalTo: 'foo')
    end
  end

  describe 'equal_to_json' do
    it 'returns a hash of { equalToJson => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.equal_to_json 'foo'
      expect(builder.to_hash).to eq(equalToJson: 'foo')
    end

    it 'returns a hash of { equalToJson => value, ignoreArrayOrder => true }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.equal_to_json 'foo', true
      expect(builder.to_hash).to eq(equalToJson: 'foo', ignoreArrayOrder: true)
    end

    it 'returns a hash of { equalToJson => value, ignoreExtraElements => true }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.equal_to_json 'foo', false, true
      expect(builder.to_hash).to eq(equalToJson: 'foo', ignoreExtraElements: true)
    end
  end

  describe 'equal_to_xml' do
    it 'returns a hash of { equalToXml => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.equal_to_xml 'foo'
      expect(builder.to_hash).to eq(equalToXml: 'foo')
    end
  end

  describe 'matching' do
    it 'returns a hash of { matches => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.matching 'foo'
      expect(builder.to_hash).to eq(matches: 'foo')
    end
  end

  describe 'matching_json_path' do
    it 'returns a hash of { matchesJsonPath => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.matching_json_path 'foo'
      expect(builder.to_hash).to eq(matchesJsonPath: 'foo')
    end
  end

  describe 'matching_xpath' do
    it 'returns a hash of { matchesXPath => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.matching_xpath 'foo'
      expect(builder.to_hash).to eq(matchesXPath: 'foo')
    end
  end

  describe 'not_matching' do
    it 'returns a hash of { doesNotMatch => value }' do
      builder = WireMockMapper::MatchBuilder.new(nil)
      builder.not_matching 'foo'
      expect(builder.to_hash).to eq(doesNotMatch: 'foo')
    end
  end
end
