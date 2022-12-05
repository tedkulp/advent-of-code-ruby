# frozen_string_literal: true

module Year2022
  class Day01 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      get_sums.max
    end

    def part_2
      get_sums
        .sort
        .reverse
        .take(3)
        .sum
    end

    private

    def get_sums
      data
        .chunk(&:empty?)                           # Chunk it up by empty lines
        .reject { |grp| grp[0] }                   # Reject out all the empty line chunks
        .map { |grp| grp[1] }                      # Reduce it to just the chunked arrays
        .map { |callist| callist.map(&:to_i).sum } # Sum up all the chunked arrays
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
