[![Code Climate](https://codeclimate.com/github/vigetlabs/special-delivery.png)](https://codeclimate.com/github/vigetlabs/special-delivery)
# Special Delivery

__A Mailgun Webhook Event Manager__

Special Delivery is a Rails engine that enables powerful and easy-to-use callbacks in response to Mailgun events POSTed via webhook.

Say what now? Example time:

Let's say you have an application that sends an email to notify a user that they have won the lottery. This email is obviously pretty important, so we'd like to send a message to an admin if the lotter-winner email bounces. How the heck do we do that?

Special Delivery saves a reference to each outgoing email messages to recreate state when Mailgun informs your application that a particular event occured for that message.

So by using Special Delivery when sending out a lottery-winner email, the application is then able to listen for bounce events for that particular email, and evaluate a callback with knowlege of the user record to which the email was originally sent.

## Installation
You know the drill. Add the gem to your Gemfile.

```ruby
gem 'special-delivery'
```

## Use
### Routes File
Mount Special Delivery as an engine within your `config/routes.rb` at a path of your choosing. Make sure to then point your Mailgun webhooks to this URL.

```ruby
mount SpecialDelivery::Engine => "/email_events"
```

### Your Custom Callback Class File
Create a new class to handle callbacks initiated by Mailgun POST requests made to your app.  Callbacks for the specific types of Mailgun events should be defined as methods within your class. Your class can respond to as many or as few of Mailgun's event types as you would like. Event types include `bounced`, `clicked`, `complained`, `delivered`, `dropped`, `opened`, and `unsubscribed`.

So if we want a callback class to manage sending a message to an admin when our lottery winner emails bounce, we would write:

```ruby
class LotteryEmail::WinnerCallback < SpecialDelivery::Callback
  def bounced(user)
  	send_message_to_admin "#{user.name} did not receive their lottery winner email."
  end
end
```

And if we wanted to send a different message to the admin when the email was opened, we could add a method to the callback class:

```ruby
def opened(user)
 send_message_to_admin "#{user.name} just opened their lottery winner email."
end
```

### Mailer Files
Include the Mailer helper module in your mailer class (e.g. `app/mailers/lottery_mailer.rb` if you wanted to use Special Delivery in your LotteryMailer.

```ruby
class LotteryMailer < ActionMailer::Base
  include SpecialDelivery::Mailer
  
  ...
```

Within your mailer's methods, pass your `mail` method calls into `special_delivery` as a block. Pass the `special_delivery` method call a hash containing at least your callback class (at `:callback_class` of course). You may optionally provide an ActiveRecord object for `:callback_record` that will be passed into your callback method as an argument.

```ruby
def winner_email(user)
  special_delivery(
    :callback_class  => LotteryEmail::WinnerCallback,
    :callback_record => user
  ) do
  	mail(:to => user.email, :subject => 'All the Monies!')
  end
end
```