# Tsubaki

[![Circle CI](https://circleci.com/gh/kakipo/tsubaki/tree/master.svg?style=svg)](https://circleci.com/gh/kakipo/tsubaki/tree/master)

Each resident in Japan will be notified of his or her own Individual Number (a.k.a. "My Number") beginning in October 2015.

A My Number consists of 12 digits & the last digit is used as a check digit.
This gem provides My Number validator which inspects the format and (optionally) the check digit.  

(We plan to implement other social security related code validators such as a basic pension number validator later.)

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

Add the following to your model:

```ruby
validates :my_number, my_number: true
```

## Verify the check digit

In order to have stricter validation which verifies the check digit, enable strict mode.

```ruby
validates :my_number, my_number: { strict: true }
```

See: [行政手続における特定の個人を識別するための番号の利用等に関する法律の規定による通知カード及び個人番号カード並びに情報提供ネットワークシステムによる特定個人情報の提供等に関する省令](http://law.e-gov.go.jp/announce/H26F11001000085.html)

## Divider

If a My Number contains any dividers, specify it.

```ruby
# 1111-2222-3333-4444 should be valid
validates :my_number, my_number: { divider: '-' }
```

## Goodies

You can obtain a random yet having right check digit My Number.
This is useful when creating dummy records.

```ruby
Tsubaki::MyNumber.rand # => 765895492872
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kakipo/tsubaki.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

