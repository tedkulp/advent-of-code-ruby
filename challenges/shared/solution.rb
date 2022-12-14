# frozen_string_literal: true %>

class Solution
  def self.part_1(*input)
    obj = new(*input)
    method_defined?(:part1) ? obj.part1 : obj.part_1
  end

  def self.part_2(*input)
    obj = new(*input)
    method_defined?(:part2) ? obj.part2 : obj.part_2
  end

  def self.part1(*input)
    obj = new(*input)
    method_defined?(:part1) ? obj.part1 : obj.part_1
  end

  def self.part2(*input)
    obj = new(*input)
    method_defined?(:part2) ? obj.part2 : obj.part_2
  end

  def initialize(input)
    @input = input
  end

  def part_1
    part1
  end

  def part_2
    part2
  end

  def data
    @data ||= begin
      processed = @input.lines(chomp: true).map do |line|
        process_input line
      end

      processed.length == 1 ? processed.first : process_dataset(processed)
    end
  end

  private

  def process_input(line)
    line
  end

  def process_dataset(set)
    set
  end
end
