#!/usr/bin/env ruby
require 'statsd'
require 'faker'

#s = Statsd.new "192.168.57.1"
s = Statsd.new

loop do 
  s.count :mycounter, 10-Random.rand(20)
  s.gauge :mygauge, Random.rand(20)
  s.timing :mytime, Random.rand(200)/10.0
  s.set :myset, Faker::Lorem.word
  s.increment "accessapi"
  s.timing "hello#alg=#{%w(old new).sample}", Random.rand(5000)/2.0
  s.batch do |s|
    s.increment('page.views')
    s.gauge('users.online', 123)
  end
  sleep 0.1
end
