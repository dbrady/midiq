#!/usr/bin/env ruby

require 'rubygems'
require 'beanstalk-client'
require 'midiator'

host = ARGV[0] || 'localhost'

bs = Beanstalk::Pool.new ["#{host}:11300"]

30.times do
  bs.put "S 38 0.1 10 127"
  sleep 0.1
end

bs.put "M 36 1.0 10 127"
bs.put "M 39 1.0 10 127"
bs.put "M 38 1.0 10 127"
bs.put "M 40 1.0 10 127"
bs.put "M 49 1.0 10 127"
bs.put "M 49 1.0 10 127"
bs.put "M 49 1.0 10 127"
