# frozen_string_literal: true

require 'set'

module Year2022
  class Rope
    attr_reader :head, :tail, :tail_position_list

    def initialize(head_pos: [0, 0], tail_pos: [0, 0], size: 2)
      @knots = Array.new(size).map { head_pos.dup }
      @last_idx = size - 1
      @knots[@last_idx] = tail_pos
      @tail_position_list = Set.new
      @tail_position_list << @knots.last.dup
    end

    def head
      @knots.first
    end

    def tail
      @knots.last
    end

    def make_moves(data)
      data.each do |move|
        dir, count = move.split(' ')
        count = count.to_i

        case dir
        when 'R'
          move_right count
        when 'L'
          move_left count
        when 'U'
          move_up count
        when 'D'
          move_down count
        end
      end
    end

    def move_up(count)
      1.upto(count).each do
        move_tail([0, 1])
      end
    end

    def move_down(count)
      1.upto(count).each do
        move_tail([0, -1])
      end
    end

    def move_left(count)
      1.upto(count).each do
        move_tail([-1, 0])
      end
    end

    def move_right(count)
      1.upto(count).each do
        move_tail([1, 0])
      end
    end

    private

    def should_move?(head, tail)
      dist = [head.first - tail.first, head.last - tail.last].map(&:abs)
      dist.first > 1 || dist.last > 1 || dist.sum > 2
    end

    def move_tail(transform)
      @knots.each_with_index do |h, idx|
        next if idx == @knots.length - 1

        h = @knots[idx]
        t = @knots[idx + 1]

        if idx.zero?
          _h = h.zip(transform).map { |m, n| m + n }
          h[0] = _h[0]
          h[1] = _h[1]
        end

        next unless should_move?(h, t)

        t[0] = t[0] + ((h[0] - t[0]) / (h[0] - t[0]).abs) if h[0] != t[0]
        t[1] = t[1] + ((h[1] - t[1]) / (h[1] - t[1]).abs) if h[1] != t[1]
      end

      @tail_position_list << @knots.last.dup
    end
  end

  class Day09 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      rope = Rope.new
      rope.make_moves(data)
      rope.tail_position_list.uniq { |(a, b)| [a, b].join(',') }.length
    end

    def part_2
      rope = Rope.new(size: 10)
      rope.make_moves(data)
      rope.tail_position_list.uniq { |(a, b)| [a, b].join(',') }.length
    end
  end
end
