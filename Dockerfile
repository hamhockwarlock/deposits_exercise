FROM ruby:3.3.0

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT [ "./entrypoint.sh" ]
EXPOSE 9999

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "9999"]
