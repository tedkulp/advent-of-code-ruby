# frozen_string_literal: true

module Year2022
  class Day10 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def initialize(input)
      @input = input
      @cycle = 1
      @register = 1
      @total = 0
      @pixels = []
    end

    def lower_bound
      @register
    end

    def upper_bound
      [@register + 2, 40].min
    end

    def cur_col
      col = @cycle.modulo(40)
      col > 0 ? col : 40
    end

    def cycle
      @total += @cycle * @register if @cycle == 20 or (@cycle + 20).modulo(40) == 0

      @pixels << @cycle if cur_col >= lower_bound and cur_col <= upper_bound

      @cycle += 1
    end

    def addx(amt)
      cycle
      cycle

      @register += amt
    end

    def run
      data.each do |line|
        case line
        when 'noop'
          cycle
        else
          addx line.split(/ /).last.to_i
        end
      end
    end

    def part_1
      run

      @total
    end

    def part_2
      run

      (0..5).map do |y|
        (1..40).map do |x|
          @pixels.include?(x + (y * 40)) ? '#' : '.'
        end.join
      end.join("\n")
    end
  end
end
