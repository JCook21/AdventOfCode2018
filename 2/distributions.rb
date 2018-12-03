#!/usr/bin/env ruby
require 'damerau-levenshtein'

ids = File.readlines('ids.txt').map(&:strip)

# Part one
twos = 0
threes = 0
candidates = []
ids.each do |id|
  counts = id.split('')
             .each_with_object(Hash.new(0)) { |letter, hash| hash[letter] += 1 }
             .values
  continue unless counts.include?(2) || counts.include?(3)
  twos += 1 if counts.include?(2)
  threes += 1 if counts.include?(3)
  candidates.push(id)
end

puts twos * threes

# Part two
prototypes = candidates.permutation(2).find do |a, b|
  DamerauLevenshtein.distance(a, b) == 1
end

first = prototypes[0].split('')
second = prototypes[1].split('')
second -= ((first - second) | (second - first))

puts second.join
