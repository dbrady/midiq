#!/usr/bin/env ruby

require 'rubygems'
require 'beanstalk-client'
require 'midiator'
 

host = ARGV[0] || 'localhost'

midi = MIDIator::Interface.new
midi.use("dls_synth")

midi.control_change 32, 10, 1 # TR-808 is Program 26 in LSB bank 1
midi.program_change 10, 26

midi.program_change 2, 17

include MIDIator::Drums

bs = Beanstalk::Pool.new ["#{host}:11300"]

puts "Ready."

done = false

while not done
  msg = bs.reserve
  puts msg.body
  cmd = msg.body.split
  
  case cmd[0]
  when 'Q' then done = true
  when 'S' then midi.play cmd[1].to_i, cmd[2].to_f, cmd[3].to_i, cmd[4].to_i
  when 'M' then Thread.new { midi.play cmd[1].to_i, cmd[2].to_f, cmd[3].to_i, cmd[4].to_i }
  end
  msg.delete
end
