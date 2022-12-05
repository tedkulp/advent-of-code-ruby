# frozen_string_literal: true

module Year2022
  class Day02 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      data
        .map { |line| round_score(line) + input_score(line[2]) }
        .sum
    end

    def part_2
      data
        .map { |line| "#{line[0]} #{calculate_move(line)}" }
        .map { |line| round_score(line) + input_score(line[2]) }
        .sum
    end

    private

    def input_score(char)
      case char
      when 'A', 'X'
        1
      when 'B', 'Y'
        2
      when 'C', 'Z'
        3
      end
    end

    # Losing Combo, Winning Combo
    # Rock Beats Scissors  A Z, C X
    # Scissors Beats Paper C Y, B Z
    # Paper Beats Rock     B X, A Y

    def round_score(line)
      case line
      when 'C X', 'B Z', 'A Y'
        6
      when 'A Z', 'C Y', 'B X'
        0
      when 'A X', 'B Y', 'C Z'
        3
      else
        puts 'huh?' + line
      end
    end

    # OMG, this is so year #1 CS student...
    def calculate_move(line)
      them, outcome = line.split(' ')
      if outcome == 'X' # Lose
        if them == 'A'
          'Z'
        elsif them == 'B'
          'X'
        else
          'Y'
        end
      elsif outcome == 'Z' # Win
        if them == 'A'
          'Y'
        elsif them == 'B'
          'Z'
        else
          'X'
        end
      elsif them == 'A' # Draw
        'X'
      elsif them == 'B'
        'Y'
      else
        'Z'
      end
    end
  end
end
