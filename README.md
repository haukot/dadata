# Dadata

[Dadata.ru](https://dadata.ru/) API integration wrapper for ruby projects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dadata'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dadata

## Usage

```ruby
require 'dadata'

dadata = Dadata::Suggestion.new(api_key: 'YOURKEY')
dadata.organization('ООО Рога и копыта')
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rgarifullin/dadata.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
