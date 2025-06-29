FROM ruby:3.2

WORKDIR /app

COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 3011

CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "3011"]
