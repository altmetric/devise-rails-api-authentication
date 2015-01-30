FROM ruby:2.2

WORKDIR /app
ADD . /app
RUN bundle install --jobs 4
