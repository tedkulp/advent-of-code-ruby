# frozen_string_literal: true

class Array
  def map_with_subject
    return to_enum :map_with_subject unless block_given?

    each_with_index.map do |e, idx|
      yield(e, self, idx)
    end
  end
end

module Year2022
  class Matter
    attr_reader :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def pos
      "#{x},#{y}"
    end

    def eql?(other)
      other = other.dup
      x == other.x && y == other.y
    end

    alias == eql?

    def hash
      x.hash * y.hash
    end

    def inspect
      self.class.name.split('::').last + ': ' + [@x, @y].join(',')
    end
  end

  class Rock < Matter
  end

  class Sandball < Matter
    def initialize(x, y, cave)
      super(x, y)

      @cave = cave
    end

    def move
      if !@cave.matter_here?(@x, @y + 1)
        @y += 1
      elsif !@cave.matter_here?(@x - 1, @y + 1)
        @x -= 1
        @y += 1
      elsif !@cave.matter_here?(@x + 1, @y + 1)
        @x += 1
        @y += 1
      else
        false
      end
    end

    def in_bottomless_pit?
      p [@y, @cave.bounds]
      @y > @cave.bounds[3] + 1
    end
  end

  class Cave
    attr_reader :rocks

    def initialize(rocks: [], add_floor: false)
      @rocks = Set.new(rocks.flatten(1))
      @start_point = [500, 0]

      self.add_floor if add_floor

      b = bounds.dup
      @grid = Array.new(b[3] + 10) { Array.new(bounds[1] + 10) }

      @rocks.each do |rock|
        @grid[rock.y][rock.x] = rock
      end
    end

    def bounds
      [@rocks.map(&:x).minmax,
       @rocks.map(&:y).minmax].flatten
    end

    def add_floor
      b = bounds.dup
      add_amt = 250

      ((b[0] - add_amt)..(b[1] + add_amt)).each { |x| rocks << Rock.new(x, b[3] + 2) }
    end

    def draw
      b = bounds
      (-1..b[3] + 1).each do |y|
        blah = (b[0] - 1..b[1] + 1).map do |x|
          mat = matter_at(x, y)
          next '#' if mat.is_a?(Rock)
          next 'o' if mat.is_a?(Sandball)

          '.'
        end.to_a.join
        p blah
      end
    end

    def rock_here?(x, y)
      !!rock_at(x, y)
    end

    def sand_here?(x, y)
      !!sand_at(x, y)
    end

    def matter_here?(x, y)
      rock_here?(x, y) || sand_here?(x, y)
    end

    def sand_at(x, y)
      obj = @grid[y][x]
      obj && obj.is_a?(Sandball) && obj
    end

    def rock_at(x, y)
      obj = @grid[y][x]
      obj && obj.is_a?(Rock) && obj
    end

    def matter_at(x, y)
      sand_at(x, y) || rock_at(x, y)
    end

    def too_far?(y)
      y > (bounds[3] + 1)
    end

    def no_space_left?(y)
      y.zero?
    end

    def run
      count = 0
      loop do
        current_ball = Sandball.new(*@start_point, self)

        loop do
          y = current_ball.move
          break if !y || too_far?(y) || no_space_left?(y)
        end

        break if too_far?(current_ball.y)

        count += 1
        p ['count', count]
        @grid[current_ball.y][current_ball.x] = current_ball

        break if no_space_left?(current_ball.y)
      end

      count
    end
  end

  class Day14 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      cave = Cave.new(rocks: data)
      ans = cave.run
      cave.draw
      ans
    end

    def part_2
      cave = Cave.new(rocks: data, add_floor: true)
      ans = cave.run
      cave.draw
      ans
    end

    # Processes each line of the input file and stores the result in the dataset
    def process_input(line)
      line
        .split(' -> ')
        .map { |ln| ln.split(',').map(&:to_i) }
        .map_with_subject do |(x1, y1), list, idx|
          next if idx >= list.length - 1

          x2, y2 = list[idx + 1]

          next (x1..x2).map { |x| Rock.new(x, y1) } if x2 > x1
          next (y1..y2).map { |y| Rock.new(x1, y) } if y2 > y1
          next (x2..x1).map { |x| Rock.new(x, y1) } if x1 > x2
          next (y2..y1).map { |y| Rock.new(x1, y) } if y1 > y2
        end
        .reject(&:nil?)
        .flatten(1)
    end
  end
end
