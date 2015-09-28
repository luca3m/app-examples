#!/usr/bin/env ruby
require 'redis'
require 'faker'

$redis = Redis.new(host: ENV["REDIS_HOST"])

if ARGV[0]
  $speed = ARGV[0].to_f
else
  $speed = 0.5
end

loop do
  Random.rand(10).times do
    $redis.rpush Faker::Lorem.word, Faker::Lorem.paragraph
  end
  sleep $speed
end
