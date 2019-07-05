# Queries Watch

An overview of the number of queries is output to the log and browser console.

`log/development.log`:

```
Queries total_count: 5, cached_count: 0, exec_count: 5, total_duration: 4.4ms
```

Browser console:

[![Image from Gyazo](https://i.gyazo.com/6cc0653c42ed02fa3b2cdb312897e40f.png)](https://gyazo.com/6cc0653c42ed02fa3b2cdb312897e40f)

## Usage

In `app/views/layout/application.html.haml`:

```haml
!!!
%html
  %head
    %title MyAPP
    = favicon_link_tag '/favicon.ico'
  %body
    = yield
    - if Rails.env.development?
      = queries_watch_summary
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'queries_watch', group: 'development'
```

And then execute:

```
$ bundle
```

## Configuration

In `config/initializers/queries_watch.rb`, you can configure the following values.

```ruby
if Rails.env.development?
  QueriesWatch.configure do |config|
    config.warn_threshold = 30 # default: nil
    config.error_threshold = 100  # default: nil
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the QueriesWatch project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/aki77/queries_watch/blob/master/CODE_OF_CONDUCT.md).
