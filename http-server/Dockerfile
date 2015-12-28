FROM coopermaa/alpine-ruby
EXPOSE 4567
ADD . /app
RUN cd /app && bundle install
WORKDIR /app
CMD bundle exec ruby http.rb -o 0.0.0.0
