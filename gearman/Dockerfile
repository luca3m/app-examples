FROM coopermaa/alpine-ruby
MAINTAINER Luca Marturana <lucamarturana@gmail.com>
WORKDIR /code
ADD client.rb worker.rb /code/
RUN gem install gearman
ENV GEARMAN_HOST gearman
ENTRYPOINT [ "bundle", "exec", "ruby" ]
CMD [ "worker.rb" ]
