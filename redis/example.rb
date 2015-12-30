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
  k = Faker::Lorem.word
  v = Faker::Lorem.paragraph
  $redis.set k, v
  $redis.get k
  $redis.del k
  sleep $speed
end
