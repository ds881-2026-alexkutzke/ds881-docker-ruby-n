#Build
FROM ruby:3.2-alpine AS builder

WORKDIR /app

RUN apk add --no-cache build-base

COPY Gemfile .

RUN bundle install

COPY . .

#Produção
FROM ruby:3.2-alpine

WORKDIR /app

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app /app

#Execução
EXPOSE 8080

CMD ["ruby", "server.rb"]