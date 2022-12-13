# frozen_string_literal: true

require 'spec_helper'
RSpec.describe Year2022::HeightMap do
  let(:example_input) do
    <<~EOF
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi
    EOF
      .lines(chomp: true)
  end

  describe 'calc_height' do
    before do
      @obj = described_class.new([])
    end

    it 'gives the right height' do
      expect(@obj.calc_elevation('a')).to eq(0)
      expect(@obj.calc_elevation('z')).to eq(25)
      expect(@obj.calc_elevation('A')).to eq(nil)
      expect(@obj.calc_elevation('*')).to eq(nil)
    end
  end

  describe 'init/parse' do
    before do
      @obj = described_class.new(example_input)
    end

    it 'sets the initial points' do
      expect(@obj.start.pos).to eq([0, 0])
      expect(@obj.finish.pos).to eq([5, 2])
    end

    it 'does the max_x/y stuff' do
      expect(@obj.max_x).to eq(7)
      expect(@obj.max_y).to eq(4)
    end
  end

  describe 'elevation_at_point' do
    before do
      @obj = described_class.new(example_input)
    end

    it 'works' do
      expect(@obj.elevation_at_point(0, 0)).to eq(0)
      expect(@obj.elevation_at_point(5, 2)).to eq(25)
    end
  end

  describe 'get_next_points' do
    before do
      @obj = described_class.new(example_input)
    end

    it 'works' do
      expect(@obj.get_next_points(3, 1).map(&:pos)).to contain_exactly([3, 2], [3, 0], [2, 1]) # Other two are too low in elevation
      expect(@obj.get_next_points(0, 0).map(&:pos)).to contain_exactly([0, 1], [1, 0])
      expect(@obj.get_next_points(7, 4).map(&:pos)).to contain_exactly([7, 3], [6, 4])
    end
  end
end

RSpec.describe Year2022::Day12 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/12/input.txt')) }
  let(:example_input) do
    <<~EOF
      Sabqponm
      abcryxxl
      accszExk
      acctuvwj
      abdefghi
    EOF
  end

  describe 'part 1' do
    it 'returns the correct example result' do
      expect(described_class.part_1(example_input)).to eq(31)
    end

    it 'returns the correct real result' do
      expect(described_class.part_1(input)).to eq(412)
    end
  end

  describe 'part 2' do
    it 'returns the correct example result' do
      expect(described_class.part_2(example_input)).to eq(29)
    end

    it 'returns the correct real result' do
      expect(described_class.part_2(input)).to eq(402)
    end
  end
end
