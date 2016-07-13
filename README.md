[![Build Status](https://travis-ci.org/ike18t/wiremock_mapper.png?branch=master)](https://travis-ci.org/ike18t/wiremock_mapper)
[![Code Climate](https://codeclimate.com/github/ike18t/wiremock_mapper/badges/gpa.svg)](https://codeclimate.com/github/ike18t/wiremock_mapper)
[![Test Coverage](https://codeclimate.com/github/ike18t/wiremock_mapper/badges/coverage.svg)](https://codeclimate.com/github/ike18t/wiremock_mapper/coverage)
[![Dependency Status](https://gemnasium.com/badges/github.com/ike18t/wiremock_mapper.svg)](https://gemnasium.com/github.com/ike18t/wiremock_mapper)
[![Gem Version](https://badge.fury.io/rb/wiremock_mapper.svg)](https://badge.fury.io/rb/wiremock_mapper)

##WireMockMapper

**Ruby DSL for setting up WireMock mappings**

####Usage Example
```ruby
WireMockMapper::Configuration.set_wiremock_url('http://my_wiremock.com')
WireMockMapper::Configuration.add_header('Some-Header', 'some_value')

WireMockMapper.create_mapping do |request, respond|
	request.post_to_path('path/to/stub')
			.with_header('Some-Other-Header', 'some_other_value')
			.with_body(foo: bar)
	respond.with_body('good job!')
end
```

###### Special thanks to [Manheim](https://www.manheim.com)'s [Seller Tools](https://sites.google.com/site/sellertoolsteam/home) team for allowing me to work on this during the team Hackathon.
