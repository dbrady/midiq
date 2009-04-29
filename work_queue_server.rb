#!/usr/bin/env ruby

require 'rubygems'
require 'beanstalk-client'
require 'midiator'

srand(Time.now.to_i)

host = ARGV[0] || 'localhost'
num = (ARGV[1] || 60).to_i

bs = Beanstalk::Pool.new ["#{host}:11300"]

chord = [0, 2, 5]

puts "Sending #{num} jobs..."
num.times do
  n = (rand(5)+4)*12 + chord[rand(3)]
  dur = 0.15 + rand() / 6
  msg = "S #{n} #{'%5.3f' % dur} 1 127"
  puts msg
  bs.put msg
end
