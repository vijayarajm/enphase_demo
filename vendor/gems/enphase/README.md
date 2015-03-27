# Enphase

The [Enlighten Systems API](https://developer.enphase.com/docs) is a JSON-based API that provides access to performance data for a PV (Photovoltaic) system. This gem provides a wrapper for the following API methods.

  1. get_enphase_feed
  2. get_enphase_summary
  3. get_enphase_last_7_day_summaries
  4. get_enphase_last_7_day_stats
  5. get_enphase_today_stats
  6. get_enphase_historical_stats
  7. get_enphase_energy_lifetime


## Setup Prerequisites
1. [Ruby 2.1.5](https://www.ruby-lang.org/en/downloads/)
2. [Bundler](http://bundler.io/)


## Dependencies
1. [Faraday](https://github.com/lostisland/faraday)
2. [JSON](https://github.com/flori/json)
3. [Activesupport](https://rubygems.org/gems/activesupport/versions/3.2.18)


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'enphase'
```
If you are using it in development environment, you might have to specify the path of the gem:

```ruby
gem 'enphase', :path => "dir/path_to_enphase/enphase"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enphase


## Usage

# Summary API
# get_enphase_summary 
# Enphase.get_enphase_summary(enphase_user_id, system_id)
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_summary("4d7a45774e6a41320a", 67)
```

# Summary API
# get_enphase_feed 
# Enphase.get_enphase_feed(enphase_user_id, system_id, {:summary_date => summary_date})
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_feed("4d7a45774e6a41320a", 67, {:summary_date => "2015-01-02"})
```

# Summary API
# get_enphase_last_7_day_summaries
# Enphase.get_enphase_last_7_day_summaries(enphase_user_id, system_id)
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_last_7_day_summaries("4d7a45774e6a41320a", 67)
```

# Stats API
# get_enphase_last_7_day_stats
# Enphase.get_enphase_last_7_day_stats(enphase_user_id, system_id)
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_last_7_day_stats("4d7a45774e6a41320a", 67)
```

# Stats API
# get_enphase_today_stats
# Enphase.get_enphase_today_stats(enphase_user_id, system_id)
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_today_stats("4d7a45774e6a41320a", 67)
```

# Stats API
# get_enphase_historical_stats
# Enphase.get_enphase_historical_stats(enphase_user_id, system_id. { :start_at => start_at_timestamp, :end_at => end_at_timestamp })
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_historical_stats("4d7a45774e6a41320a", 67, 
                      { :start_at => "1411822918", :end_at => "1414414914"} )
```

# Energy API
# get_enphase_energy_lifetime
# Enphase.get_enphase_energy_lifetime(enphase_user_id, system_id)
# Example:
```ruby
require "enphase"
response = Enphase.get_enphase_energy_lifetime("4d7a45774e6a41320a", 67)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/enphase/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
