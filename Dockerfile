FROM ruby:2.6.3
ENV LANG=C.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=C.UTF-8

RUN apt-get update -y && \
   apt-get install -y \
   build-essential \
   curl \
   libssl-dev \
   libyaml-dev \
   git-core \
   libpq-dev \
   joe \
   pkg-config

ENV GEM_HOME=/usr/local/bundle/ruby/2.6.0/

RUN gem install bundler

ENV APP_DIR=/code

WORKDIR $APP_DIR
ADD Gemfile $APP_DIR
ADD Gemfile.lock $APP_DIR
RUN bundle

ADD . $APP_DIR

CMD /bin/bash
