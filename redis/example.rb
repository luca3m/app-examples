#!/usr/bin/env ruby
require 'redis'
require 'faker'

$redis = Redis.new(host: ENV["REDIS_HOST"])

loop do
  Random.rand(10).times do
    $redis.rpush Faker::Lorem.word, Faker::Lorem.paragraph
  end
  sleep 1
end
