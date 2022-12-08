# frozen_string_literal: true

module Year2022
  class Day08 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      transpose(process_lines).map do |line|
        tree_idx = -1
        line.select do |tree|
          tree_idx += 1

          next true if tree_idx.zero? || tree_idx == line.length - 1

          line[0..tree_idx - 1].all? { |ln| ln.last < tree.last } ||
            line[tree_idx + 1..].all? { |ln| ln.last < tree.last }
        end
      end.flatten(1).uniq { |el| "#{el[0]},#{el[1]}" }.length
    end

    def part_2
      arys = process_lines2
      arys.keys.map { |pos| calculate_scenic_score(arys, pos) }.max
    end

    def calculate_scenic_score(arys, pos)
      cur_x, cur_y = pos
      target_height = arys[pos]

      dir1 = (0..cur_x - 1).to_a.reverse.map { |x| [x, cur_y] }
      dir2 = (cur_x + 1..max_length - 1).to_a.map { |x| [x, cur_y] }
      dir3 = (0..cur_y - 1).to_a.reverse.map { |y| [cur_x, y] }
      dir4 = (cur_y + 1..max_length - 1).to_a.map { |y| [cur_x, y] }

      calculate_line_of_sight(arys, dir1, target_height) *
        calculate_line_of_sight(arys, dir2, target_height) *
        calculate_line_of_sight(arys, dir3, target_height) *
        calculate_line_of_sight(arys, dir4, target_height)
    end

    def calculate_line_of_sight(arys, dir, target_height)
      [dir.take_while { |t| arys[t] < target_height }.length + 1, dir.length].min
    end

    def process_lines2
      return @trees if @trees

      trees = {}
      data
        .each_with_index do |line, y|
          line.split(//).map(&:to_i).each_with_index do |v, x|
            trees[[x, y]] = v
          end
        end
      @trees = trees
      @trees
    end

    def max_length
      transpose(process_lines).map(&:length).max
    end

    def transpose(arys)
      arys + arys.transpose
    end

    def process_lines
      data
        .enum_for(:each_with_index)
        .map do |line, idx|
          line.split(//).map(&:to_i).enum_for(:each_with_index).map do |v, idx2|
            [idx, idx2, v]
          end
        end
    end
  end
end
