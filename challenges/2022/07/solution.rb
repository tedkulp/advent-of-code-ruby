# frozen_string_literal: true

module Year2022
  class Day07 < Solution
    # @input is available if you need the raw data input
    # Call `data` to access either an array of the parsed data, or a single record for a 1-line input file

    def part_1
      process_dirs.select { |_path, size| size <= 100_000 }.values.sum
    end

    def part_2
      free = 70_000_000 - get_dirs[['/']]
      to_free_up = 30_000_000 - free
      process_dirs
        .values
        .select { |size| size > to_free_up }
        .min
    end

    def process_dirs
      dirs = Hash.new(0)
      get_files.each do |(*path, _file), size|
        while path.any?
          dirs[path.dup] += size
          path.pop
        end
      end
      dirs
    end

    def process_files
      cwd = []
      files = {}
      data.each do |line|
        case line.split
        in ['$', 'cd', '..']
          cwd.pop
        in ['$', 'cd', dir]
          cwd << dir
        in [/\d+/ => size, file]
          files[cwd + [file]] = size.to_i
        end
      end
      files
    end
  end
end
