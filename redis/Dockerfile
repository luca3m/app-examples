FROM coopermaa/alpine-ruby
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD Gemfile Gemfile.lock example.rb /code/
RUN bundle install
ENV REDIS_HOST redis
ENTRYPOINT [ "bundle", "exec", "ruby", "example.rb" ]
