# Ahoy Events

:seedling: Simple, powerful event tracking for Rails

Track events in:

- JavaScript
- Ruby
- Native apps

And store them wherever you’d like - your database, logs, external services, or all of them.

## Installation

First, [add Ahoy](https://github.com/ankane/ahoy#installation).

Next, add this line to your application’s Gemfile:

```ruby
gem 'ahoy_events'
```

Lastly, include the javascript file in `app/assets/javascripts/application.js` after Ahoy.

```javascript
//= require ahoy
//= require ahoy_events
```

## How It Works

Each event has a `name` and `properties`.

There are three ways to track events.

#### JavaScript

```javascript
ahoy.track("Viewed book", {title: "The World is Flat"});
```

#### Ruby

```ruby
ahoy.track "Viewed book", title: "Hot, Flat, and Crowded"
```

#### Native Apps

Send a `POST` request to `/ahoy/events` with:

- name
- properties
- user token (depends on your authentication framework)
- `Ahoy-Visit` header

Requests should have `Content-Type: application/json`.

## Storing Events

You choose how to store events.

### ActiveRecord

Create an `Ahoy::Event` model to store events.

```sh
rails generate ahoy_events:active_record
rake db:migrate
```

### Custom

Create your own subscribers in `config/initializers/ahoy.rb`.

```ruby
class LogSubscriber

  def track(name, properties, options = {})
    data = {
      name: name,
      properties: properties,
      time: options[:time].to_i,
      visit_id: options[:visit].try(:id),
      user_id: options[:user].try(:id),
      ip: options[:controller].try(:request).try(:remote_ip)
    }
    Rails.logger.info data.to_json
  end

end

# and add it
Ahoy.subscribers << LogSubscriber.new
```

Add as many subscribers as you’d like.

## Reference

Track all Rails actions

```ruby
class ApplicationController < ActionController::Base
  after_filter :track_action

  protected

  def track_action
    ahoy.track "Hit action", request.filtered_parameters
  end
end
```

Use a different model [master]

```ruby
Ahoy.subscribers << Ahoy::Subscribers::ActiveRecord.new(model: Event)
```

## TODO

- Ability to track JavaScript events automatically (button clicks, etc)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/ahoy_events/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/ahoy_events/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
