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

COPY bin/run /usr/bin/
RUN chmod +x /usr/bin/run
ENTRYPOINT ["bin/run"]
EXPOSE 8080

CMD ["bin/run"]
