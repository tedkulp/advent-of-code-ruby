# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Day14 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/14/input.txt')) }
  let(:example_input) do
    <<~EOF
      498,4 -> 498,6 -> 496,6
      503,4 -> 502,4 -> 502,9 -> 494,9
    EOF
  end

  describe 'part 1' do
    it 'returns the correct response for the example data' do
      expect(described_class.part_1(example_input)).to eq(24)
    end

    it 'returns the correct response for the real data' do
      expect(described_class.part_1(input)).to eq(862)
    end
  end

  describe 'part 2' do
    it 'returns nil for the example input' do
      expect(described_class.part_2(example_input)).to eq(nil)
    end

    it 'returns nil for my input' do
      expect(described_class.part_2(input)).to eq(nil)
    end
  end
end
