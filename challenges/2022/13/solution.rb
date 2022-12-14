# frozen_string_literal: true

require 'json'

module Year2022
  class Day13 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def self.in_correct_order?(line1, line2)
      %i[left_ran_out left_smaller].include?(order_of(line1, line2))
    end

    def self.order_of(line1, line2)
      compare(line1, line2)
    end

    def self.compare(line1, line2, depth = 1)
      return :equal if line2.empty? && line1.empty?

      result = line1.each_with_index.map do |item, idx|
        other_item = line2[idx]
        item, other_item = normalize(item, other_item)

        if other_item.nil?
          return :right_ran_out
        elsif item.is_a?(Array) && other_item.is_a?(Array)
          retval = compare(item, other_item, depth + 1)
          return retval unless retval == :equal
        elsif item < other_item
          return :left_smaller
        elsif item > other_item
          return :right_smaller
        elsif idx == line1.length - 1 # Last item
          return :left_ran_out if line2.length > line1.length
          return :equal if item == other_item
        end
      end

      result == [] ? :left_ran_out : result
    end

    def self.is_left_empty?(line1, line2)
      line1, line2 = normalize(line1, line2)
      true if line1.empty? && line2.length > 0
    end

    def self.normalize(item1, item2)
      item1 = [item1] if item1.is_a?(Integer) && item2.is_a?(Array)
      item2 = [item2] if item1.is_a?(Array) && item2.is_a?(Integer)

      [item1, item2]
    end

    def parsify(line1, line2)
      [JSON.parse(line1), JSON.parse(line2)]
    end

    def strip(line)
      ltr_map = ('a'..'z').to_a
      line.gsub(/(\d+)/) do |_|
        match = Regexp.last_match
        ltr_map.at(match[1].to_i)
      end.gsub(/\W/, '')
    end

    def part1
      data
        .each_slice(2)
        .each_with_index.map do |(line1, line2), idx|
          line1 = JSON.parse(line1)
          line2 = JSON.parse(line2)
          Day13.in_correct_order?(line1, line2) && idx + 1
        end
        .filter { |n| n.is_a?(Integer) }
        .sum
    end

    def part2
      extras = ['[[2]]', '[[6]]']
      data
        .append(*extras)
        .sort do |line1, line2|
        xline1 = strip(line1)
        xline2 = strip(line2)

        next -1 if xline1 == '' && xline2 != ''
        next 1 if xline2 == '' && xline1 != ''

        next line1.length <=> line2.length if xline1 == xline2

        xline1 <=> xline2
      end
        .each_with_index
        .map { |ln, idx| extras.include?(ln) && idx + 1 }
        .filter { |ln| ln.is_a?(Integer) }
        .inject(&:*)
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    def process_dataset(set)
      set.reject(&:nil?).reject(&:empty?)
    end
  end
end
