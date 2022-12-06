# frozen_string_literal: true

module Year2022
  class Day03 < Solution
    @@letter_pos = ('a'..'z').to_a + ('A'..'Z').to_a

    def part_1
      data
        .map { |ln| split_string(ln) }                                # Split the strings in half
        .map { |halves| halves.first.intersection(halves[1]) }        # Find the intersection of the two halves
        .flatten                                                      # Make a single array
        .map { |ltr| get_pos(ltr) }                                   # Map the letters to their values
        .sum                                                          # Sum it all up
    end

    def part_2
      data
        .map { |str| str.split(//) }                                  # Split the strings into individual chars
        .each_slice(3)                                                # Slice into groups of 3
        .to_a                                                         # Turn the enumerator into an array
        .map { |parts| parts.first.intersection(parts[1], parts[2]) } # Get the intersection of each group
        .flatten                                                      # Make a single array
        .map { |ltr| get_pos(ltr) }                                   # Map the letters to their values
        .sum                                                          # Sum it all up
    end

    def split_string(str)
      str.chars.each_slice(str.length / 2).to_a
    end

    def get_pos(ltr)
      @@letter_pos.index(ltr) + 1
    end
  end
end
