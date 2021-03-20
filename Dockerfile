FROM ruby:2.7.1
ENV LANG C.UTF-8

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev

RUN gem install bundler -v 2.1.4

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

WORKDIR /app
COPY . /app

