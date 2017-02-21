module WireMockMapper
  module Builders
    module Helpers
      class << self
        def regexp_to_string(regexp)
          %r{^/(.*)/$}.match(regexp.inspect)[1]
        end
      end
    end
  end
end
