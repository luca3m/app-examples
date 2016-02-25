#!/usr/bin/env ruby
require 'redis'
require 'faker'

$redis = Redis.new(host: ENV["REDIS_HOST"])

loop do
  k = Faker::Lorem.word
  v = Faker::Lorem.paragraph
  $redis.set k, v
  $redis.get k
  $redis.del k
  if ARGV[0]
    sleep ARGV[0].to_f
  else
    sleep Random.rand
  end
end
