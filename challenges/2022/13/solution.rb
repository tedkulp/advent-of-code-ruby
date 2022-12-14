# frozen_string_literal: true

require 'json'

module Year2022
  class Packet
    attr_reader :data

    def initialize(data)
      data = JSON.parse(data) if data.is_a?(String)
      @data = data
    end

    def int?
      @data.is_a?(Integer)
    end

    def array?
      @data.is_a?(Array)
    end

    def to_s
      @data.to_s
    end

    def inspect
      @data
    end

    def pad(ary, count)
      ary.dup.fill(nil, ary.length...count)
    end

    def zip(other)
      max = [@data, other.data].map(&:length).max
      pad(@data, max).zip(pad(other.data, max))
    end

    def <(other)
      return @data < other.data if int? && other.int?
      return Packet.new([@data]) < other if int? && other.array?
      return self < Packet.new([other.data]) if array? && other.int?

      zip(other).any? do |i1, i2|
        if i1.nil?
          break true
        elsif i2.nil?
          break false
        else
          next if i1 == i2

          break Packet.new(i1) < Packet.new(i2)
        end
      end
    end

    def <=>(other)
      self < other ? -1 : 1
    end
  end

  class Day13 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def self.in_correct_order?(line1, line2)
      Packet.new(line1) < Packet.new(line2)
    end

    def part1
      data
        .each_slice(2)
        .each_with_index.map do |(line1, line2), idx|
          Day13.in_correct_order?(line1, line2) && idx + 1
        end
        .filter { |n| n.is_a?(Integer) }
        .sum
    end

    def part2
      extras = ['[[2]]', '[[6]]']
      data
        .append(*extras)
        .map { |ln| Packet.new(ln) }
        .sort
        .each_with_index
        .map { |ln, idx| extras.include?(ln.to_s) && idx + 1 }
        .filter { |ln| ln.is_a?(Integer) }
        .inject(&:*)
    end

    # Processes the dataset as a whole
    def process_dataset(set)
      set.reject(&:nil?).reject(&:empty?)
    end
  end
end
