# DeviseRailsApiAuthentication [![Build Status](https://travis-ci.org/altmetric/devise-rails-api-authentication.svg?branch=master)](https://travis-ci.org/altmetric/devise-rails-api-authentication)

Token-based rails-api authentication with Devise.

Devise does not support [token-based authentication anymore](https://github.com/plataformatec/devise/issues/2739)
and [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth) does not work with rails-api.

It's basically [this gist](https://gist.github.com/josevalim/fb706b1e933ef01e4fb6) wrapped as a gem with specs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise_rails_api_authentication'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devise_rails_api_authentication

## Usage

First of all make sure you have a model class with `authentication_token` and `email` fields.
Otherwise create a migration, here's an example for a `User` model and ActiveRecord:

```ruby
class AddDeviseToUsers < ActiveRecord::Migration
  def self.change
    add_column :users, :email, :text, null: false, default: ''
    add_index :users, :email, unique: true
    add_column :users, :authentication_token, :text, null: false, default: ''
    add_index :users, :authentication_token, unique: true
  end
end
```

Next add the following lines to ApplicationController - see [source](https://github.com/altmetric/devise-rails-api-authentication/blob/master/lib/devise_rails_api_authentication/context.rb):

```ruby
class ApplicationController
  include DeviseRailsApiAuthentication::Context

  private def user
    User.where(email: user_email).first
  end
end
```

and the following line to your model class - see [source](https://github.com/altmetric/devise-rails-api-authentication/blob/master/lib/devise_rails_api_authentication/authenticatable.rb):

```ruby
class YourUserModel
  include DeviseRailsApiAuthentication::Authenticatable
end
```

Once you run the migration, create a new user, and boot up your app, just do:

```shell
curl -H "X_USER_EMAIL: <email>" -H "X_USER_TOKEN: <token>" http://<where-your-app-lives>
```

## Contributing

1. Fork it ( https://github.com/altmetric/devise_rails_api_authentication/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

This project is released under the [MIT license](https://github.com/altmetric/devise-rails-api-authentication/blob/master/LICENSE.txt).
