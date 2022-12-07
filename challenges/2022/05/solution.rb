# frozen_string_literal: true

module Year2022
  class Day05 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      towers = get_initial_towers
      get_moves.each do |move|
        num, from, to = move.map { |i| i.to_i }
        items = towers[from.to_s].pop(num).reverse
        towers[to.to_s].push(*items)
      end
      towers.values.map { |vs| vs.last }.join
    end

    def part_2
      towers = get_initial_towers
      get_moves.each do |move|
        num, from, to = move.map { |i| i.to_i }
        items = towers[from.to_s].pop(num)
        towers[to.to_s].push(*items)
      end
      towers.values.map { |vs| vs.last }.join
    end

    def get_initial_towers
      pattern = data
                .chunk(&:empty?) # Chunk it up by empty lines
                .first
                .at(1)
      len = pattern.map(&:length).max
      pattern.map do |str|
        str
          .ljust(len)
          .split(//)
      end
             .transpose
             .map { |ary| ary.reverse }
             .filter { |ary| ary.first.match?(/^[0-9]+$/) }
             .each_with_object({}) do |item, memo|
        first, *rest = *item
        memo.store(first, rest.reject { |str| str == ' ' })
      end
    end

    def get_moves
      pattern = data
                .chunk(&:empty?) # Chunk it up by empty lines
                .to_a
                .at(2)
                .at(1)
                .map { |ln| ln.match(/move ([0-9]+) from ([0-9]+) to ([0-9]+)/).captures }
    end
  end
end
