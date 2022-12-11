# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Barrel do
  let(:example_input) do
    <<~EOF
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3

      Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
          If true: throw to monkey 2
          If false: throw to monkey 0

      Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
          If true: throw to monkey 1
          If false: throw to monkey 3

      Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
          If true: throw to monkey 0
          If false: throw to monkey 1
    EOF
  end

  describe 'init' do
    it 'splits the list' do
      expect(described_class.new(example_input).data.length).to eq(4)
    end

    it 'creates one monkey per item' do
      expect(described_class.new(example_input).monkeys.length).to eq(4)
    end

    it 'sets the starting items' do
      expect(described_class.new(example_input).monkeys.first.worry_vals).to eq([79, 98])
      expect(described_class.new(example_input).monkeys.last.worry_vals).to eq([74])
    end

    it 'sets the operation' do
      expect(described_class.new(example_input).monkeys.first.operation).to eq(['*', 19])
      expect(described_class.new(example_input).monkeys.last.operation).to eq(['+', 3])
    end

    it 'sets the test' do
      expect(described_class.new(example_input).monkeys.first.test_divisor).to eq(23)
    end

    it 'sets the true/false cases' do
      expect(described_class.new(example_input).monkeys.first.true_case).to eq(2)
      expect(described_class.new(example_input).monkeys.first.false_case).to eq(3)
    end
  end
end

RSpec.describe Year2022::Monkey do
  describe 'calc' do
    it 'calculates + correctly' do
      monkey = described_class.new
      expect(monkey.calc(15, '+', 5)).to eq(20)
    end

    it 'calculates * correctly' do
      monkey = described_class.new
      expect(monkey.calc(4, '*', 5)).to eq(20)
    end
  end

  describe 'get_bored' do
    before do
      @monkey = described_class.new
    end

    it 'calculates correctly' do
      expect(@monkey.get_bored(18)).to eq(6)
      expect(@monkey.get_bored(19)).to eq(6)
      expect(@monkey.get_bored(17)).to eq(5)
    end
  end

  describe 'update_item' do
    it 'makes sure the item exists' do
      monkey = described_class.new
      monkey.items = [Year2022::Item.new(20)]
      expect(monkey.update_item(monkey.items.first)).to eq(nil)
    end

    it 'makes updates the item in hand and returns that value' do
      monkey = described_class.new
      monkey.items = [Year2022::Item.new(20)]
      monkey.operation = ['+', 5]

      expect(monkey.update_item(monkey.items.first).worry).to eq(8)
      expect(monkey.worry_vals).to include(8)
      expect(monkey.worry_vals).not_to include(20)
    end
  end
end

RSpec.describe Year2022::Day11 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/11/input.txt')) }
  let(:example_input) do
    <<~EOF
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3

      Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
          If true: throw to monkey 2
          If false: throw to monkey 0

      Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
          If true: throw to monkey 1
          If false: throw to monkey 3

      Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
          If true: throw to monkey 0
          If false: throw to monkey 1
    EOF
  end

  describe 'part 1' do
    it 'returns the correct response' do
      expect(described_class.part_1(example_input)).to eq(10_605)
    end

    it 'returns the correct real response' do
      expect(described_class.part_1(input)).to eq(64_032)
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
