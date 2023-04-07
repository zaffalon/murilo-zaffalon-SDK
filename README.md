# Elessar Ruby Library

Elessar - In the book, Elessar is a green gemstone that is a symbol of the kingship of Gondor.

The Elessar Ruby library provides convenient access to the The Lord of the Rings API from
applications written in the Ruby language.

## Rubygems

Gem published to [Rubygems](https://rubygems.org/gems/elessar).

## Documentation

See the [The Lord of the Rings API docs](https://the-one-api.dev/documentation).

## Installation

You don't need this source code unless you want to modify the gem. If you just
want to use the package, just run:

```sh
gem install elessar
```

If you want to build the gem from source:

```sh
gem build elessar.gemspec
```

### Requirements

- Ruby 2.3+.

### Bundler

If you are installing via bundler, you should be sure to use the https rubygems
source in your Gemfile, as any gems fetched over http could potentially be
compromised in transit and alter the code of gems fetched securely over https:

```ruby
gem 'elessar'
```

## Usage

The library needs to be configured with your account's secret key which is
available in your [The Lord of the Rings Account](https://the-one-api.dev/account). Set `Elessar.api_key` to its
value:

```ruby
require 'elessar'
Elessar.api_key = 'aR9j-...'

# list movies
movies = Elessar::Movie.list()
movie.data.docs.first.name

# retrieve single movie
movie = Elessar::Movie.retrieve('5cd95395de30eff6ebccde5b')
movie.data.docs.first.name

# list quotes
quote = movie.list_quotes()
quote.data.docs.first.dialog
```

### Params
```ruby
# using params as hash
Elessar::Movie.list({limit: 3, page: 2})

# using params as string
Elessar::Movie.list("budgetInMillions<100")
```


### Configuring Automatic Retries

You can enable automatic retries on requests that fail due to a transient
problem by configuring the maximum number of retries:

```ruby
Elessar.max_network_retries = 2
```

Various errors can trigger a retry, like a connection error or a timeout, and
also certain API responses like HTTP status `409 Conflict`.

### Configuring Timeouts

Open, read timeouts are configurable:

```ruby
Elessar.open_timeout = 30 # in seconds
Elessar.read_timeout = 80
```


## Development

Instructions to run tests:

```sh
bundle install
```

Run all tests:

```sh
bundle exec ruby test/run_test.rb
```

Run a single test:

```sh
bundle exec ruby test/elessar_test.rb
```