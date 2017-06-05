FROM ruby:alpine
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD Gemfile Gemfile.lock /code/
RUN bundle install
ADD metric_gen.rb /code/
ENTRYPOINT [ "bundle", "exec", "ruby", "metric_gen.rb" ]
