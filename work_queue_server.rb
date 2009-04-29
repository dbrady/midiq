#!/usr/bin/env ruby

require 'rubygems'
require 'beanstalk-client'
require 'midiator'

host = ARGV[0] || 'localhost'

bs = Beanstalk::Pool.new ["#{host}:11300"]

chord = [0, 2, 5]

60.times do
  n = (rand(5)+4)*12
  dur = 0.15 + rand() / 6
  bs.put "S #{n} #{dur} 1 127"
end
