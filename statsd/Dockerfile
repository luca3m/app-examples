FROM coopermaa/alpine-ruby
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD Gemfile Gemfile.lock metric_gen.rb /code/
RUN bundle install
ENTRYPOINT [ "bundle", "exec", "ruby", "metric_gen.rb" ]
