FROM ruby
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD . /code/
RUN gem install pg faker
ENV POSTGRES postgres
ENTRYPOINT [ "ruby", "example.rb" ]
