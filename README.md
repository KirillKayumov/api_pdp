# API for Social PDP

[![Code Climate](https://codeclimate.com/github/KirillKayumov/api_pdp/badges/gpa.svg)](https://codeclimate.com/github/KirillKayumov/api_pdp)
[![Test Coverage](https://codeclimate.com/github/KirillKayumov/api_pdp/badges/coverage.svg)](https://codeclimate.com/github/KirillKayumov/api_pdp/coverage)
[![Build Status](https://semaphoreci.com/api/v1/kirill_kayumov/api_pdp/branches/master/shields_badge.svg)](https://semaphoreci.com/kirill_kayumov/api_pdp)

## What's included

### Application gems:

* [Decent Exposure](https://github.com/voxdolo/decent_exposure) for DRY controllers
* [Rollbar](https://github.com/rollbar/rollbar-gem) for exception notification
* [Thin](https://github.com/macournoyer/thin) as rails web server
* [Kaminari](https://github.com/amatsuda/kaminari) for pagination
* [Rack CORS](https://github.com/cyu/rack-cors) for [CORS](http://en.wikipedia.org/wiki/Cross-origin_resource_sharing)

### Development gems

* [Foreman](https://github.com/ddollar/foreman) for managing development stack with Procfile
* [Letter Opener](https://github.com/ryanb/letter_opener) for preview mail in the browser instead of sending
* [Mail Safe](https://github.com/myronmarston/mail_safe) keep ActionMailer emails from escaping into the wild during development
* [Bullet](https://github.com/flyerhzm/bullet) gem to kill N+1 queries and unused eager loading
* [Rails Best Practices](https://github.com/railsbp/rails_best_practices) code metric tool
* [Brakeman](https://github.com/presidentbeef/brakeman) static analysis security vulnerability scanner
* [Bundler Audit](https://github.com/rubysec/bundler-audit) Patch-level verification for Gems
* [Spring](https://github.com/rails/spring) for fast Rails actions via pre-loading

### Testing gems

* [Factory Girl](https://github.com/thoughtbot/factory_girl) for easier creation of test data
* [RSpec](https://github.com/rspec/rspec) for awesome, readable isolation testing
* [Shoulda Matchers](http://github.com/thoughtbot/shoulda-matchers) for frequently needed Rails and RSpec matchers
* [Email Spec](https://github.com/bmabey/email-spec) Collection of rspec matchers and cucumber steps for testing emails
* [Rspec Api Documentation](https://github.com/zipmark/rspec_api_documentation) Generate pretty API docs for your Rails APIs

### Initializes

* `01_config.rb` - shortcut for getting application config with `app_config`
* `mailer.rb` - setup default hosts for mailer from configuration
* `requires.rb` - automatically requires everything in lib/ & lib/extensions
* `rack_cors.rb` - setup whitelist of domains to allow cross-origin resource sharing

### Scripts

* `bin/setup` - setup required gems and migrate db if needed
* `bin/quality` - runs rubocop, brakeman, rails_best_practices and bundle-audit for the app
* `bin/ci` - should be used in the CI or locally
* `bin/server` - to run server locally

### Serializers

### PaginatedArraySerializer

Use that serializer if you want to add meta with pagination info on response

```ruby
def index
  respond_with(
    posts,
    serializer: PaginatedArraySerializer
  )
end
```

The above usage of `PaginatedArraySerializer` will produce the following:

```json
{
  "meta": {
    "pagination": {
      "total":46,
      "per_page":2,
      "page":1
    }
  },
  "posts": [
    { "title": "Post 1", "body": "Hello!" },
    { "title": "Post 2", "body": "Goodbye!" }
  ]
}
```
