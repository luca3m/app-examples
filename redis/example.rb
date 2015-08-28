#!/usr/bin/env ruby

require 'redis'

loop do
  redis = Redis.new(host: ENV["REDIS_HOST"])
  Random.rand(10).times do
    redis.incr :mycounter
  end
  sleep 0.2
end
