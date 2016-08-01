module WireMockMapper
  module Builders
    module Helpers
      def self.regexp_to_string regexp
        /^\/(.*)\/$/.match(regexp.inspect)[1]
      end
    end
  end
end

