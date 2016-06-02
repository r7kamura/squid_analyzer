# SquidAnalyzer

Data analyzer for Splatoon.

## Installation

Install OpenCV 2.x (The installation code below is for OS X):

```sh
brew tap homebrew/science
brew install opencv
```

And add this line to your application's Gemfile:

```ruby
gem "squid_analyzer"
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install squid_analyzer
```

## Requirements

SquidAnalyzer is tested on:

- Mac OS X 10.10.5
- OpenCV 2.4.12_2
- Ruby 2.2.0
- [Intensity Shuttle for USB 3.0](https://www.blackmagicdesign.com/jp/products/intensity)

## Usage

Use `squid_analyzer` executable.

```sh
squid_analyzer
```

## Current status

- [x] Game result scene recognition
- [x] Digits recognition
- [x] Kill/Death count recognition on game result scene
- [ ] Regular/Ranked match recognition on game result scene
- [ ] Game start scene recognition
- [ ] Stage type recognition on game start scene
- [ ] Game rule recognition on game start scene

For example, we can recognize the following data from game result scene.

```json
{
  "lose_players": [
    {
      "deaths_count": 6,
      "kills_count": 8
    },
    {
      "deaths_count": 12,
      "kills_count": 9
    },
    {
      "deaths_count": 9,
      "kills_count": 3
    },
    {
      "deaths_count": 6,
      "kills_count": 3
    }
  ],
  "type": "GameResult",
  "win_players": [
    {
      "deaths_count": 7,
      "kills_count": 8
    },
    {
      "deaths_count": 7,
      "kills_count": 6
    },
    {
      "deaths_count": 5,
      "kills_count": 9
    },
    {
      "deaths_count": 4,
      "kills_count": 10
    }
  ]
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/r7kamura/squid_analyzer.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
