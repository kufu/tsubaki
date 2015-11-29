# Tsubaki

[![Circle CI](https://circleci.com/gh/kufu/tsubaki/tree/master.svg?style=svg)](https://circleci.com/gh/kufu/tsubaki/tree/master)

Each resident in Japan will be notified of his or her own Individual Number (a.k.a. "My Number") beginning in October 2015, and each company will be given its own Corporate Number likewise.

This gem provides both My Number and Corporate Number validators which inspect the format and (optionally) the check digit.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tsubaki'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tsubaki

## Usage


### My Number

A My Number consists of 12 digits & the last digit is used as a check digit.

To validate the format of an attribute, add the following to your model:

```ruby
# Verifies the format and its check digit with `strict` option:
validates :digits, my_number: { strict: true }, allow_nil: true

# Without strict option, it verifies only the length of the digits:
validates :digits, my_number: true

# Or if a My Number contains any dividers, specify it:
validates :digits, my_number: { strict: true, divider: '-' } # => 4652-8126-6333 should be valid
```

### Corporate Number

A Corporate Number consists of 13 digits & the first digit is used as a check digit.

To validate the format of an attribute, add the following to your model:

```ruby
# Verifies the format and its check digit with `strict` option:
validates :digits, corporate_number: { strict: true }, allow_nil: true

# Without strict option, it verifies only the length of the digits:
validates :digits, corporate_number: true

# Or if a Corporate Number contains any dividers, specify it:
validates :digits, corporate_number: { strict: true, divider: '-' } # => 5-8356-7825-6246 should be valid
```



## Goodies

### Rspec matchers

To ensure appropriate validations are specified, Tsubaki includes rspec matchers.

```ruby
# In spec_helper.rb, you'll need to require the matchers:
require 'tsubaki/matchers'

# And include the module:
RSpec.configure do |config|
  config.include Tsubaki::Shoulda::Matchers
end
```

```ruby
describe User do
  # For My Number validation
  it { should validate_my_number_of(:digits) }

  # To ensure options:
  it { should validate_validate_my_number_of(:digits).strict.with_divider('-').allow_nil }
end

describe Company do
  # For Corporate Number validation
  it { should validate_corporate_number_of(:digits) }

  # To ensure options:
  it { should validate_validate_corporate_number_of(:digits).strict.with_divider('-') }
end
```


### Random number generators

You can obtain a random yet having right check digit numbers.
This is useful when creating dummy records.

```ruby
Tsubaki::MyNumber.rand # => 765895492872
Tsubaki::CorporateNumber.rand # => 5868731863533
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kufu/tsubaki.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

