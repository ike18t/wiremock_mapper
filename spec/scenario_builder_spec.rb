require 'spec_helper'

describe WireMockMapper::Builders::ScenarioBuilder do
  let(:builder) { WireMockMapper::Builders::ScenarioBuilder.new }

  describe 'in_scenario' do
    it 'sets the scenario name' do
      builder.in_scenario('some scenario')
      result = builder.to_hash
      expect(result[:scenarioName]).to eq('some scenario')
    end
  end

  describe 'with_state' do
    it 'sets the required state of the request' do
      builder.with_state('initial state')
      result = builder.to_hash
      expect(result[:requiredScenarioState]).to eq('initial state')
    end
  end

  describe 'will_set_state' do
    it 'sets the state value to be toggled to' do
      builder.will_set_state('updated state')
      result = builder.to_hash
      expect(result[:newScenarioState]).to eq('updated state')
    end
  end
end
