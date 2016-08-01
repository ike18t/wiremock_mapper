require 'spec_helper'

describe WireMockMapper::Builders::MatchBuilder do
  let(:builder) { WireMockMapper::Builders::MatchBuilder.new(nil) }

  describe 'absent' do
    it 'returns a hash of { absent => true }' do
      builder.absent
      expect(builder.to_hash).to eq(absent: true)
    end
  end

  describe 'containing' do
    it 'returns a hash of { contains => value }' do
      builder.containing 'foo'
      expect(builder.to_hash).to eq(contains: 'foo')
    end
  end

  describe 'equal_to' do
    it 'returns a hash of { equalTo => value }' do
      builder.equal_to 'foo'
      expect(builder.to_hash).to eq(equalTo: 'foo')
    end
  end

  describe 'equal_to_json' do
    it 'returns a hash of { equalToJson => value }' do
      builder.equal_to_json 'foo'
      expect(builder.to_hash).to eq(equalToJson: 'foo')
    end

    it 'returns a hash of { equalToJson => value, ignoreArrayOrder => true }' do
      builder.equal_to_json 'foo', true
      expect(builder.to_hash).to eq(equalToJson: 'foo', ignoreArrayOrder: true)
    end

    it 'returns a hash of { equalToJson => value, ignoreExtraElements => true }' do
      builder.equal_to_json 'foo', false, true
      expect(builder.to_hash).to eq(equalToJson: 'foo', ignoreExtraElements: true)
    end
  end

  describe 'equal_to_xml' do
    it 'returns a hash of { equalToXml => value }' do
      builder.equal_to_xml 'foo'
      expect(builder.to_hash).to eq(equalToXml: 'foo')
    end
  end

  describe 'matching' do
    it 'returns a hash of { matches => value }' do
      builder.matching 'foo'
      expect(builder.to_hash).to eq(matches: 'foo')
    end

    it 'converts the regex to a string and returns a hash of { matches => value }' do
      builder.matching(/foo(s)?/)
      expect(builder.to_hash).to eq(matches: 'foo(s)?')
    end
  end

  describe 'matching_json_path' do
    it 'returns a hash of { matchesJsonPath => value }' do
      builder.matching_json_path 'foo'
      expect(builder.to_hash).to eq(matchesJsonPath: 'foo')
    end
  end

  describe 'matching_xpath' do
    it 'returns a hash of { matchesXPath => value }' do
      builder.matching_xpath 'foo'
      expect(builder.to_hash).to eq(matchesXPath: 'foo')
    end
  end

  describe 'not_matching' do
    it 'returns a hash of { doesNotMatch => value }' do
      builder.not_matching 'foo'
      expect(builder.to_hash).to eq(doesNotMatch: 'foo')
    end

    it 'converts the regex to a string and returns a hash of { doesNotMatch => value }' do
      builder.matching(/foo(s)?/)
      expect(builder.to_hash).to eq(matches: 'foo(s)?')
    end
  end
end
