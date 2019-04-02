FROM ruby:2.6.2-stretch

EXPOSE 3000

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN rails db:setup
RUN rails test

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
