#!/usr/bin/env ruby
require 'set'

class FabricSquare
  alias == eql?
  attr_accessor :id
  @regexp = /(\d+)\s@\s(\d+),(\d+):\s(\d+)x(\d+)/
  def initialize(x, y, id)
    @x = x
    @y = y
    @id = id
  end

  def eql?(other)
    other.class == self.class && other.state == state
  end

  def hash
    state.hash
  end

  def self.parse_from_string(raw)
    matcher = @regexp.match(raw)
    id = matcher[1]
    x_start = matcher[2].to_i
    y_start = matcher[3].to_i
    width = matcher[4].to_i
    height = matcher[5].to_i
    (0...width).flat_map { |x| (0...height).map { |y| FabricSquare.new(x + x_start, y + y_start, id) } }
  end

  protected

  def state
    [@x, @y]
  end
end

data = File.readlines('fabric.txt')
           .map(&:strip)
           .flat_map { |val| FabricSquare.parse_from_string(val) }

# Part one
claimed = Set.new
duplicates = Set.new
data.each do |square|
  duplicates.add(square) unless claimed.add?(square)
end

puts duplicates.size

# Part two
no_overlaps = data.group_by(&:id)
                  .find { |_k, v| (duplicates & v).empty? }

puts no_overlaps[0]
