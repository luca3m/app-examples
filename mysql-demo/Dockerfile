FROM ruby
ADD Gemfile /app/
WORKDIR /app
RUN bundle
ADD app.rb /app/
ENTRYPOINT [ "bundle", "exec", "ruby", "app.rb" ]
