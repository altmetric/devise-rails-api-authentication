FROM ruby:2.2

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD devise_rails_api_authentication.gemspec /app/devise_rails_api_authentication.gemspec
ADD lib/devise_rails_api_authentication/version.rb /app/lib/devise_rails_api_authentication/version.rb
RUN bundle install --jobs 4
ADD . /app
