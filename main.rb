#!/usr/bin/env ruby
# NoSQL with Redis
# Tyler Radabaugh

require 'redis'

redis = Redis.new

redis.set('Todd', 'Beagle')
value = redis.get('Todd')
puts value
redis.del('Todd')
value = redis.get('Todd')
puts value
