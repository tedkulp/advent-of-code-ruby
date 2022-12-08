# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day08 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/08/input.txt')) }
  let(:example_input) do
    <<~EOF
      30373
      25512
      65332
      33549
      35390
    EOF
  end

  describe 'part 1' do
    it 'returns the correct result' do
      expect(described_class.part_1(example_input)).to eq(21)
    end
  end

  describe 'part 2' do
    before do
      @cls = described_class.new(example_input)
      @arys = @cls.process_lines2
    end

    it 'calculates the max length' do
      expect(@cls.max_length).to eq(5)
    end

    it 'calculates the scenic score' do
      expect(@cls.calculate_scenic_score(@arys, [2, 1])).to eq(4)
      expect(@cls.calculate_scenic_score(@arys, [2, 3])).to eq(8)
    end

    # it 'returns the correct result' do
    #   expect(described_class.part_2(example_input)).to eq(8)
    # end
  end
end
