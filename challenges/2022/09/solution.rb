# frozen_string_literal: true

module Year2022
  class Rope
    attr_reader :head, :tail, :tail_position_list, :head_position_list

    def initialize(head_pos = [0, 0], tail_pos = [0, 0])
      @head = head_pos
      @tail = tail_pos
      @head_position_list = [head_pos.dup]
      @tail_position_list = [tail_pos.dup]
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
        head_x, head_y = @head

        @head = [head_x, head_y + 1]
        @head_position_list << @head

        move_tail([head_x, head_y], @head)
      end
    end

    def move_down(count)
      1.upto(count).each do
        head_x, head_y = @head

        @head = [head_x, head_y - 1]
        @head_position_list << @head

        move_tail([head_x, head_y], @head)
      end
    end

    def move_left(count)
      1.upto(count).each do
        head_x, head_y = @head

        @head = [head_x - 1, head_y]
        @head_position_list << @head

        move_tail([head_x, head_y], @head)
      end
    end

    def move_right(count)
      1.upto(count).each do
        head_x, head_y = @head

        @head = [head_x + 1, head_y]
        @head_position_list << @head

        move_tail([head_x, head_y], @head)
      end
    end

    private

    def diff(a, b)
      (a - b).abs
    end

    def move_tail(old_head_pos, new_head_pos)
      old_head_x, old_head_y = old_head_pos
      tail_x, tail_y = @tail

      @tail = [old_head_x, old_head_y] if diff(new_head_pos.first, tail_x) > 1 || diff(new_head_pos.last, tail_y) > 1

      @tail_position_list << @tail unless tail_x == @tail.first && tail_y == @tail.last
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
      nil
    end
  end
end
