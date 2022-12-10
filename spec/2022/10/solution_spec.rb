# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day10 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/10/input.txt')) }
  let(:example_input1) do
    <<~EOF
      noop
      addx 3
      addx -5
    EOF
  end

  let(:example_input2) do
    <<~EOF
      addx 15
      addx -11
      addx 6
      addx -3
      addx 5
      addx -1
      addx -8
      addx 13
      addx 4
      noop
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx 5
      addx -1
      addx -35
      addx 1
      addx 24
      addx -19
      addx 1
      addx 16
      addx -11
      noop
      noop
      addx 21
      addx -15
      noop
      noop
      addx -3
      addx 9
      addx 1
      addx -3
      addx 8
      addx 1
      addx 5
      noop
      noop
      noop
      noop
      noop
      addx -36
      noop
      addx 1
      addx 7
      noop
      noop
      noop
      addx 2
      addx 6
      noop
      noop
      noop
      noop
      noop
      addx 1
      noop
      noop
      addx 7
      addx 1
      noop
      addx -13
      addx 13
      addx 7
      noop
      addx 1
      addx -33
      noop
      noop
      noop
      addx 2
      noop
      noop
      noop
      addx 8
      noop
      addx -1
      addx 2
      addx 1
      noop
      addx 17
      addx -9
      addx 1
      addx 1
      addx -3
      addx 11
      noop
      noop
      addx 1
      noop
      addx 1
      noop
      noop
      addx -13
      addx -19
      addx 1
      addx 3
      addx 26
      addx -30
      addx 12
      addx -1
      addx 3
      addx 1
      noop
      noop
      noop
      addx -9
      addx 18
      addx 1
      addx 2
      noop
      noop
      addx 9
      noop
      noop
      noop
      addx -1
      addx 2
      addx -37
      addx 1
      addx 3
      noop
      addx 15
      addx -21
      addx 22
      addx -6
      addx 1
      noop
      addx 2
      addx 1
      noop
      addx -10
      noop
      noop
      addx 20
      addx 1
      addx 2
      addx 2
      addx -6
      addx -11
      noop
      noop
      noop
    EOF
  end

  let(:example_input3) do
    <<~EOF
      ##..##..##..##..##..##..##..##..##..##..
      ###...###...###...###...###...###...###.
      ####....####....####....####....####....
      #####.....#####.....#####.....#####.....
      ######......######......######......####
      #######.......#######.......#######.....
    EOF
  end

  let(:real_output) do
    <<~EOF
      ###..####.#..#.###..###..#....#..#.###..
      #..#.#....#..#.#..#.#..#.#....#..#.#..#.
      #..#.###..####.#..#.#..#.#....#..#.###..
      ###..#....#..#.###..###..#....#..#.#..#.
      #.#..#....#..#.#....#.#..#....#..#.#..#.
      #..#.####.#..#.#....#..#.####..##..###..
    EOF
  end

  describe 'part 1' do
    it 'returns the other correct result' do
      expect(described_class.part_1(example_input2)).to eq(13_140)
    end
  end

  describe 'part 2' do
    it 'returns the correct result' do
      expect(described_class.part_2(example_input2.chomp)).to eq(example_input3.chomp)
    end

    it 'returns the correct real result' do
      expect(described_class.part_2(input.chomp)).to eq(real_output.chomp)
    end
  end
end
