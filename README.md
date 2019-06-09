# Simple Computers

Ruby implementations of simple machines, inspired by Understanding Computation by Tom Stuart(O’Reilly). Copyright 2013 Tom Stuart, 978-1-4493-2927-3.

At the time of writing, the project contains an implementation for deterministic finite automata, via `DFA::Machine`, with more machines to be added as I continue to work through the examples in the book...

The examples in this repository were written with the aid of tests, though the book itself does not define any automated tests, it does provide working implementations and suggests interfaces, on which the examples here are largely based.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_computers'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_computers

## Usage

See `dfa_spec.rb` for an example DFA.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dino-k-29/simple_computers.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
