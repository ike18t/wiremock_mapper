module WireMockMapper
  module Builders
    class ScenarioBuilder
      # Scenarios allow for stateful behavior

      def initialize
        @options = {}
      end

      def in_scenario(scenario)
        @options[:scenarioName] = scenario
        self
      end

      def with_state(state)
        @options[:requiredScenarioState] = state
        self
      end

      def will_set_state(state)
        @options[:newScenarioState] = state
        self
      end

      def to_hash(*)
        options_with_url_match = @options.merge(@url_match.to_hash) if @url_match
        options_with_url_match || @options
      end

      def to_json(*)
        to_hash.to_json
      end
    end
  end
end
