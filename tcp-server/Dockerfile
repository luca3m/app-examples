FROM coopermaa/alpine-ruby
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD tcp-server.rb /code/
EXPOSE 2000
ENTRYPOINT [ "ruby", "tcp-server.rb" ]
