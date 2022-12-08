# frozen_string_literal: true

module Year2022
  class Grid
    attr_reader :visible_map, :scenic_scores

    def initialize(input)
      area, visible_map, scenic_scores = parse_input(input)

      @area = area
      @visible_map = visible_map
      @scenic_scores = scenic_scores
    end

    def determine_visibility
      @area.each_with_index do |row, j|
        parse_row_visibility j, 0, row.length - 1
        parse_row_visibility j, row.length - 1, 0
      end

      (0..(@area.map(&:length).max - 1)).each do |i|
        parse_column_visibility i, 0, @area.length - 1
        parse_column_visibility i, @area.length - 1, 0
      end
    end

    def determine_scenic_scores
      i_max = @area.map(&:length).max
      j_max = @area.length

      (1..(j_max - 2)).each do |j|
        (1..(i_max - 2)).each do |i|
          tree = @area[j][i]

          left = @area[j].first(i).reverse
          right = @area[j].last(i_max - i - 1)
          up = @area.first(j).map { |row| row[i] }.reverse
          down = @area.last(j_max - j - 1).map { |row| row[i] }

          directional_scores = [left, right, up, down].map do |direction|
            return 0 if direction.empty?

            visible_trees = direction.take_while { |t| t < tree }
            visible_count = visible_trees.length

            [visible_count + 1, direction.length].min
          end

          @scenic_scores[j][i] = directional_scores.reduce { |a, n| a * n }
        end
      end
    end

    private

    def parse_input(data)
      area = []
      visible_map = []
      scenic_scores = []

      data.each do |row|
        area << row.chars.map(&:to_i)
        visible_map << Array.new(row.length).map { false }
        scenic_scores << Array.new(row.length).map { 0 }
      end

      [area, visible_map, scenic_scores]
    end

    def parse_row_visibility(y, from, to)
      current_max_height = -1

      range = from < to ? from.upto(to) : from.downto(to)

      range.each do |x|
        current_tree_height = @area[y][x]

        if current_tree_height > current_max_height
          current_max_height = current_tree_height
          @visible_map[y][x] = true
        end
      end
    end

    def parse_column_visibility(x, from, to)
      current_max_height = -1

      range = from < to ? from.upto(to) : from.downto(to)

      range.each do |y|
        current_tree_height = @area[y][x]

        if current_tree_height > current_max_height
          current_max_height = current_tree_height
          @visible_map[y][x] = true
        end
      end
    end
  end

  class Day08 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      grid = Grid.new(data)
      grid.determine_visibility
      grid.visible_map.flatten.count { |tree| tree }
    end

    def part_2
      grid = Grid.new(data)
      grid.determine_scenic_scores
      grid.scenic_scores.flatten.max
    end
  end
end
