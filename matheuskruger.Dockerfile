FROM ruby:3.3
WORKDIR /app
COPY . .
RUN bundle install
EXPOSE 8080
CMD ["ruby", "server.rb", "-o", "0.0.0.0"]