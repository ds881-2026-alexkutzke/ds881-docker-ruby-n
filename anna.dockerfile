# build
FROM ruby:3.3-alpine AS builder

WORKDIR /app

RUN apk add --no-cache build-base

COPY Gemfile Gemfile.lock ./

RUN bundle config set without 'development test' \
    && bundle install \
    && rm -rf /usr/local/bundle/cache \
    && find /usr/local/bundle -name "*.o" -delete \
    && find /usr/local/bundle -name "*.c" -delete 

# runtime
FROM ruby:3.3-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /usr/local/bundle /usr/local/bundle

COPY server.rb .

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 8080

CMD ["ruby", "server.rb"]