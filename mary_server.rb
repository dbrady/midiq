#!/usr/bin/env ruby

require 'rubygems'
require 'beanstalk-client'
require 'midiator'

host = ARGV[0] || 'localhost'

bs = Beanstalk::Pool.new ["#{host}:11300"]

notes =  [59, 57, 55, 57, 59, 59, 59, 0, 57, 57, 57, 0, 59, 62, 62]

notes.each do |n|
  bs.put "S #{n} 0.5 1 127" unless n.zero?
  sleep 0.5
end
