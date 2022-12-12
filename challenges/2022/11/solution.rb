# frozen_string_literal: true

module Year2022
  class Item
    attr_accessor :worry

    def initialize(_worry)
      @worry = _worry
    end
  end

  class Barrel
    attr_reader :monkeys, :data, :round

    def initialize(input, do_they_get_bored = true)
      @round = 1
      @do_they_get_bored = do_they_get_bored
      @data = input
              .lines(chomp: true)
              .map(&:lstrip)
              .slice_when { |ln| ln.empty? }
              .to_a

      parse
    end

    def run(rounds = 20)
      (1..rounds).each do |_round_num|
        @monkeys.each_with_index do |monkey, _midx|
          item_list = monkey.items.dup
          item_list.each_with_index do |item, _idx|
            # Update
            item = monkey.update_item(item)
            # Test
            target = monkey.is_worried?(item.worry) ? monkey.true_case : monkey.false_case
            # Throw (and catch)
            monkey.throw(item)
            @monkeys[target].catch(item)
          end
        end
      end
    end

    def cycle_length
      @cycle_length ||= @monkeys.map(&:test_divisor).inject(&:*)
    end

    def inspect_counts
      @monkeys.map(&:items_inspected)
    end

    private

    def parse
      @monkeys = @data.map do |input|
        mon = Monkey.new(self, @do_they_get_bored)

        input.each do |ln|
          case ln
          when /^Starting items: (.+)$/
            mon.items = ::Regexp.last_match(1)
                                .split(/, /)
                                .map(&:to_i).map { |i| Item.new(i) }
          when /^Operation: (.+)$/
            mon.operation = ::Regexp.last_match(1)
                                    .split(/ /)[3..]
                                    .map { |s| s.match(/^\d+$/) ? s.to_i : s }
          when /^Test: divisible by (\d+)$/
            mon.test_divisor = ::Regexp.last_match(1).to_i
          when /^If true: throw to monkey (\d+)$/
            mon.true_case = ::Regexp.last_match(1).to_i
          when /^If false: throw to monkey (\d+)$/
            mon.false_case = ::Regexp.last_match(1).to_i
          end
        end

        mon
      end
    end
  end

  class Monkey
    attr_accessor :operation, :test_divisor, :true_case, :false_case, :items
    attr_reader :items_inspected

    def initialize(barrel = nil, do_i_get_bored = true)
      @items_inspected = 0
      @barrel = barrel
      @do_i_get_bored = do_i_get_bored
    end

    def empty_handed?
      @items.empty?
    end

    def throw(item)
      @items.delete(item)
    end

    def catch(item)
      @items << (item)
    end

    def worry_vals
      @items.map(&:worry)
    end

    def update_item(item)
      return if @operation.nil?
      return if @items.nil? or @items.empty?

      idx = @items.index(item)
      return unless idx

      @items_inspected += 1

      oper, num = @operation
      num = item.worry if num == 'old'

      item.worry = get_bored(calc(item.worry, oper, num))
      @items[idx] = item
    end

    def calc(item, oper, num)
      case oper
      when '+'
        item + num
      when '*'
        item * num
      end
    end

    def get_bored(worry_val)
      if @do_i_get_bored || @barrel.nil?
        (worry_val.to_f / 3).floor
      else
        worry_val.modulo(@barrel.cycle_length)
      end
    end

    def is_worried?(item)
      item.modulo(@test_divisor).zero?
    end
  end

  class Day11 < Solution
    def part_1
      barrel = Barrel.new(@input)
      barrel.run
      barrel.inspect_counts
            .sort
            .reverse
            .take(2)
            .inject(&:*)
    end

    def part_2
      barrel = Barrel.new(@input, false)
      barrel.run(10_000)
      barrel.inspect_counts
            .sort
            .reverse
            .take(2)
            .inject(&:*)
    end

    # Processes each line of the input file and stores the result in the dataset
    # def process_input(line)
    #   line.map(&:to_i)
    # end

    # Processes the dataset as a whole
    # def process_dataset(set)
    #   set
    # end
  end
end
