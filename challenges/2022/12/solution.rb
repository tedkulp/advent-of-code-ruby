# frozen_string_literal: true

module Year2022
  class PathNode
    attr_reader :x, :y, :height

    def initialize(map, x, y, height)
      @map = map
      @x = x
      @y = y
      @height = height
    end

    def pos
      [@x, @y]
    end

    def ==(other)
      x == other.x && y == other.y
    end

    def get_next_nodes
      @map.get_next_points(@x, @y)
    end

    def to_s
      "pos: #{x}, #{y} height: #{height}"
    end

    def inspect
      to_s
    end
  end

  class HeightMap
    attr_reader :start, :finish

    @@elevations = ('a'..'z').to_a

    def initialize(data)
      parse(data)

      @visited = []
    end

    def parse(data)
      @data = data.each_with_index.map do |ln, y|
        chrs = ln.chars
        chrs
          .each_with_index
          .map do |chr, x|
            if chr == 'S'
              @start = PathNode.new(self, x, y, calc_elevation('a'))
            elsif chr == 'E'
              @finish = PathNode.new(self, x, y, calc_elevation('z'))
            else
              PathNode.new(self, x, y, calc_elevation(chr))
            end
          end
      end
    end

    def get_all_nodes
      @data.map { |row| row.map.to_a }.flatten
    end

    def distance_between(node1, node2)
      node1.height < node2.height ? 1 : 0
    end

    def shortest_path
      came_from = {}
      came_from[start] = nil
      points_to_access = Queue.new
      points_to_access << start

      until points_to_access.empty?
        current = points_to_access.pop

        break if current.nil? || current == finish

        get_next_points(current.x, current.y).each do |adjacent_node|
          unless came_from.include? adjacent_node
            points_to_access << adjacent_node
            came_from[adjacent_node] = current
          end
        end
      end

      current = finish
      path = []

      while current.pos != start.pos
        path << current
        current = came_from[current]
      end

      path
    end

    def elevation_at_point(x, y)
      @data[y][x].height
    end

    def calc_elevation(ltr)
      @@elevations.index(ltr)
    end

    def max_x
      @data.map(&:length).max - 1
    end

    def max_y
      @data.length - 1
    end

    def get_next_points(x, y)
      current_elevation = elevation_at_point(x, y)

      [
        [x, y - 1],
        [x, y + 1],
        [x + 1, y],
        [x - 1, y]
      ].reject do |(dx, dy)|
        dx < 0 || dx > max_x || dy < 0 || dy > max_y
      end.reject(&:nil?).filter do |(dx, dy)|
        elevation_at_point(dx, dy) <= current_elevation + 1
      end.map do |(dx, dy)|
        @data[dy][dx]
      end
    end
  end

  class Day12 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      map = HeightMap.new(data)
      map.shortest_path.length
    end

    def part_2
      nil
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
