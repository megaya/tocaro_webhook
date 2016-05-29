# TocaroWebhook

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/tocaro_webhook`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tocaro_webhook'
```

And then execute:

```
$ bundle install
```

install palne ruby

```
$ gem install tocaro_webhook
```

## Usage

Call TocaroWebhook::Sender class.

```ruby
require 'tocaro_webhook'

webhook_sender = TocaroWebhook::Sender.new('your api key')
```

exec send message

```ruby
webhook_sender.payload.add_attachment(title: "title", value: "value", image_url: "htttp://image_url.com")
# or some attribute
# webhook_sender.payload.add_attachment(title: "title")
# webhook_sender.payload.add_attachment(value: "value")
# webhook_sender.payload.add_attachment(value: "value", image_url: "htttp://image_url.com")
webhook_sender.exec
```

some attachments

```ruby
webhook_sender.payload.add_attachment(title: "title", value: "value", image_url: "http://image_url.com")
webhook_sender.payload.add_attachment(image_url: "http://image_url.com")
webhook_sender.payload.add_attachment(title: "title", value: "value")

webhook_sender.exec
```

return HTTP response class.

```ruby
res = webhook_sender.exec
res.code # => "200"
```

## test

Send test exec when .env file write your webhook key.
Env file use dotenv gem. (https://github.com/bkeepers/dotenv)

```.env
TEST_TOCARO_WEB_HOOK_KEY="your web hook key"
```

