FROM ruby:alpine
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD . /code/
RUN bundle install
ENV MONGODB mongodb
ENTRYPOINT [ "bundle", "exec", "ruby", "example.rb" ]
