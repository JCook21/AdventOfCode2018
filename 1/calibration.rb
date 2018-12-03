#!/usr/bin/env ruby
require 'set'

values = File.readlines('calibration.txt').map(&:to_i)
# Part one
puts values.sum

# Part two
frequency = 0
seen = Set[0]
values.cycle do |value|
  frequency += value
  unless seen.add?(frequency)
    puts frequency
    break
  end
end
