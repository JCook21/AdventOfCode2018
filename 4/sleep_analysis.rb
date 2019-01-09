#!/usr/bin/env ruby

data = File.readlines('test.txt')
           .map(&:strip)

sleep_patterns = {}
current_id = nil
data.each_with_index do |row, index|
  if index.zero? || row.include?('#')
    id = row.scan(/(?<=#)\d+/).join('').to_i
    sleep_patterns[id] = Hash.new(0) unless sleep_patterns.key?(id)
    current_id = id
    next
  end
  asleep = sleep_patterns[current_id]
  asleep_match = /(\d+(?=\]\sfalls asleep))/.match(row)
  next unless asleep_match

  asleep[asleep_match[0].to_i] += 1
end
puts sleep_patterns
