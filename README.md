# Adsentry

This is a monitoring plugin for all stages of our ads life cycle.

## Installation

Add this line to your application's Gemfile:

    gem 'adsentry'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adsentry

## Usage

### Recording

To record that an ad has entered a stage of a given life cycle, you record it like:

```ruby
Adsentry::Annalist.new(:some_lifecycle_stage).insert(:some_ad_identifier)
```

Typically I use the ad's id attribute for the identifier but before the ad is actually an entry in a mysql database, I use the ad's pdf filename.

#### Exceptions

This should not raise under normal circumstances.  The Annalist calls are all wrapped to catch and report Redis errors, but not re-raise them.

It will die pretty much silently so that the actual ad processing can happen if the AdSentry takes a "break" (or falls over and dies).

### Reading

The way that this is used in the visualizations that I have built so for is simply:

```ruby
Adsentry::Aggregator.report
```

That returns something like:

```
[{name: "adsentry:some_queue", count: 0}]
```

### Alerter (tool for analyzing time series events)

This will record time-series entries into a Redis list that can then be queried for two use cases:

#### Recording

```ruby
Adsentry::Alerter.record(:associaton)
```

#### Querying

* Time since last event:

```ruby
Adsentry::Alerter.since_last_event(:associaton)
=> 0.00012111663818359375
```


* Last n queries:

```ruby
Adsentry::Alerter.last_members(:association)
=> [1383446450.892808, 1383446450.892705, 1383446450.892598, 1383446450.892475]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
