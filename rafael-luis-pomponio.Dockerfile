FROM ruby:3.3-alpine

WORKDIR /app

COPY Gemfile .

RUN apk add --no-cache --virtual .build-deps build-base \
    && bundle install \
    && apk del .build-deps

COPY server.rb .

USER nobody

EXPOSE 8080

CMD ["ruby", "server.rb", "-o", "0.0.0.0"]
