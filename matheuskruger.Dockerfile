FROM ruby:3.3-alpine AS builder
WORKDIR /app
COPY Gemfile .
RUN apk add --no-cache build-base && \
    bundle config set --local without 'development test' && \
    bundle install

FROM ruby:3.3-alpine
WORKDIR /app
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY server.rb .
EXPOSE 8080
CMD ["ruby", "server.rb", "-o", "0.0.0.0"]