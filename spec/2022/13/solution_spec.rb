# frozen_string_literal: true

require 'spec_helper'
require 'json'

RSpec.describe Year2022::Day13 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/13/input.txt')) }
  let(:example_input) do
    <<~EOF
      [1,1,3,1,1]
      [1,1,5,1,1]

      [[1],[2,3,4]]
      [[1],4]

      [9]
      [[8,7,6]]

      [[4,4],4,4]
      [[4,4],4,4,4]

      [7,7,7,7]
      [7,7,7]

      []
      [3]

      [[[]]]
      [[]]

      [1,[2,[3,[4,[5,6,7]]]],8,9]
      [1,[2,[3,[4,[5,6,0]]]],8,9]
    EOF
  end

  describe 'json' do
    before do
      @lines = example_input.lines(chomp: true).reject { |ln| ln.empty? }
    end

    it 'works on this data' do
      expect(@lines.map { |ln| JSON.parse(ln) }).not_to be_nil
    end
  end

  describe 'pairs' do
    it 'handles case 1' do
      expect(described_class.in_correct_order?([1, 1, 3, 1, 1], [1, 1, 5, 1, 1])).to be true
    end

    it 'handles case 2' do
      expect(described_class.in_correct_order?([[1], [2, 3, 4]], [[1], 4])).to be true
    end

    it 'handles case 3' do
      expect(described_class.in_correct_order?([9], [[8, 7, 6]])).to be false
    end

    it 'handles case 4' do
      expect(described_class.in_correct_order?([[4, 4], 4, 4], [[4, 4], 4, 4, 4])).to be true
    end

    it 'handles case 5' do
      expect(described_class.in_correct_order?([7, 7, 7, 7], [7, 7, 7])).to be false
    end

    it 'handles case 6' do
      expect(described_class.in_correct_order?([], [3])).to be true
    end

    it 'handles case 7' do
      expect(described_class.in_correct_order?([[[]]], [[]])).to be false
    end

    it 'handles case 8' do
      expect(described_class.in_correct_order?([1, [2, [3, [4, [5, 6, 7]]]], 8, 9],
                                               [1, [2, [3, [4, [5, 6, 0]]]], 8, 9])).to be false
    end

    it 'handles all equal' do
      expect(described_class.in_correct_order?([1, 1, 1, 1, 1], [1, 1, 1, 1, 1])).to be false
      expect(described_class.in_correct_order?([1, 1, [1, 1], 1, 1], [1, 1, [1, 1], 1, 1])).to be false
      expect(described_class.in_correct_order?([1, 1, [], 1, 1], [1, 1, [], 1, 1])).to be false
    end
  end

  describe 'part 1' do
    it 'returns correct for example input' do
      expect(described_class.part_1(example_input)).to eq(13)
    end

    it 'returns correct for real input' do
      expect(described_class.part_1(input)).to eq(5675)
    end
  end

  describe 'part 2' do
    it 'returns correct for example input' do
      expect(described_class.part_2(example_input)).to eq(140)
    end

    it 'returns correct for real input' do
      expect(described_class.part_2(input)).to eq(20_383)
    end
  end
end
