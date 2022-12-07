# frozen_string_literal: true

module Year2022
  class Day06 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      solution = 0
      get_input
        .each_index do |idx|
          slice = idx > 3 ? get_input[idx - 3..idx] : []
          solution = idx + 1 if solution == 0 and slice.length == 4 and slice.uniq.length == 4
        end
      solution
    end

    def part_2
      solution = 0
      get_input
        .each_index do |idx|
          slice = idx > 13 ? get_input[idx - 13..idx] : []
          solution = idx + 1 if solution == 0 and slice.length == 14 and slice.uniq.length == 14
        end
      solution
    end

    def get_input
      # memo hax
      @parsed_input ||= @input
                        .chomp
                        .split(//)
    end
  end
end
