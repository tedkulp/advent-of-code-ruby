# frozen_string_literal: true

module Year2022
  class Day04 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      parse_data
        .filter { |pair| in_bounds(pair[0], pair[1]) }
        .length
    end

    def part_2
      parse_data
        .reject { |pair| out_of_bounds(pair[0], pair[1]) }
        .length
    end

    def parse_data
      data
        .map do |ln|
          ln
            .split(',')
            .map do |ent|
              ent
                .split('-').map(&:to_i)
            end
        end
    end

    def in_bounds(pair1, pair2)
      (pair1[0] <= pair2[0] and pair1[1] >= pair2[1]) or
        (pair2[0] <= pair1[0] and pair2[1] >= pair1[1])
    end

    def out_of_bounds(pair1, pair2)
      (pair1[1] < pair2[0] or pair1[0] > pair2[1]) and
        (pair2[1] < pair1[0] or pair2[0] > pair1[1])
    end
  end
end
