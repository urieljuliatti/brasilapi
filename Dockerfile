FROM ruby:3.0.1-alpine

ENV BUILD_PACKAGES="linux-headers curl curl-dev build-base openssh git jq libffi-dev bash tzdata"

RUN apk --update --upgrade add $BUILD_PACKAGES && rm /var/cache/apk/* \
  && gem install bundler -v 2.3.7

WORKDIR /brasilapi

COPY Gemfile* /brasilapi

RUN bundle install

COPY . /brasilapi

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]