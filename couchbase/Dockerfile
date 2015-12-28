FROM ubuntu:trusty

RUN apt-get update && apt-get install wget ruby2.0 ruby2.0-dev && \
    wget http://packages.couchbase.com/clients/c/couchbase-csdk-setup && \
    sudo perl couchbase-csdk-setup && gem2.0 install couchbase

ADD couchbase.rb
