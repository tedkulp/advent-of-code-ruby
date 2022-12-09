# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Year2022::Rope do
  describe 'part 1' do
    describe 'moves' do
      describe 'move_right' do
        it 'pulls the tail straight' do
          @rope = described_class.new

          @rope.move_right(1)
          expect(@rope.head).to eq([1, 0])
          expect(@rope.tail).to eq([0, 0])

          @rope.move_right(2)
          expect(@rope.head).to eq([3, 0])
          expect(@rope.tail).to eq([2, 0])
        end

        it 'covers itself up when going the opposite dir' do
          @rope = described_class.new([0, 0], [1, 0])

          @rope.move_right(1)
          expect(@rope.tail).to eq([1, 0])
        end

        describe 'diagonals' do
          it 'handles the easy case' do
            @rope = described_class.new([1, 1], [0, 0])

            @rope.move_right(1)
            expect(@rope.tail).to eq([1, 1])

            @rope = described_class.new([1, 1], [0, 2])

            @rope.move_right(1)
            expect(@rope.tail).to eq([1, 1])
          end

          it 'handles multiple moves' do
            @rope = described_class.new([1, 1], [0, 0])

            @rope.move_right(3)
            expect(@rope.tail).to eq([3, 1])
            expect(@rope.tail_position_list.length).to eq(4)
          end

          it 'handles to tough case' do
            @rope = described_class.new([0, 1], [0, 0])

            @rope.move_right(1)
            expect(@rope.tail).to eq([0, 0])

            @rope = described_class.new([0, 1], [0, 0])

            @rope.move_right(3)
            expect(@rope.tail).to eq([2, 1])
            expect(@rope.tail_position_list.length).to eq(3)
          end
        end
      end

      describe 'move_left' do
        it 'pulls the tail straight' do
          @rope = described_class.new

          @rope.move_left(1)
          expect(@rope.head).to eq([-1, 0])
          expect(@rope.tail).to eq([0, 0])

          @rope.move_left(2)
          expect(@rope.head).to eq([-3, 0])
          expect(@rope.tail).to eq([-2, 0])
        end

        it 'covers itself up when going the opposite dir' do
          @rope = described_class.new([0, 0], [-1, 0])

          @rope.move_left(1)
          expect(@rope.tail).to eq([-1, 0])
        end

        describe 'diagonals' do
          it 'handles the easy case' do
            @rope = described_class.new([-1, 1], [0, 0])

            @rope.move_left(1)
            expect(@rope.tail).to eq([-1, 1])

            @rope = described_class.new([-1, 1], [0, 2])

            @rope.move_left(1)
            expect(@rope.tail).to eq([-1, 1])
          end

          it 'handles to tough case' do
            @rope = described_class.new([0, 1], [0, 0])

            @rope.move_left(1)
            expect(@rope.tail).to eq([0, 0])
          end
        end
      end

      describe 'move_up' do
        it 'pulls the tail straight' do
          @rope = described_class.new

          @rope.move_up(1)
          expect(@rope.head).to eq([0, 1])
          expect(@rope.tail).to eq([0, 0])

          @rope.move_up(2)
          expect(@rope.head).to eq([0, 3])
          expect(@rope.tail).to eq([0, 2])
        end

        it 'covers itself up when going the opposite dir' do
          @rope = described_class.new([0, 0], [0, 1])

          @rope.move_up(1)
          expect(@rope.tail).to eq([0, 1])
        end

        describe 'diagonals' do
          it 'handles the easy case' do
            @rope = described_class.new([1, 1], [0, 0])

            @rope.move_up(1)
            expect(@rope.tail).to eq([1, 1])

            @rope = described_class.new([1, 1], [2, 0])

            @rope.move_up(1)
            expect(@rope.tail).to eq([1, 1])
          end

          it 'handles to tough case' do
            @rope = described_class.new([0, -1], [0, 0])

            @rope.move_up(1)
            expect(@rope.tail).to eq([0, 0])
          end
        end
      end

      describe 'move_down' do
        it 'pulls the tail straight' do
          @rope = described_class.new

          @rope.move_down(1)
          expect(@rope.head).to eq([0, -1])
          expect(@rope.tail).to eq([0, 0])

          @rope.move_down(2)
          expect(@rope.head).to eq([0, -3])
          expect(@rope.tail).to eq([0, -2])
        end

        it 'covers itself up when going the opposite dir' do
          @rope = described_class.new([0, 0], [0, -1])

          @rope.move_down(1)
          expect(@rope.tail).to eq([0, -1])
        end

        describe 'diagonals' do
          it 'handles the easy case' do
            @rope = described_class.new([1, -1], [0, 0])

            @rope.move_down(1)
            expect(@rope.tail).to eq([1, -1])

            @rope = described_class.new([1, -1], [0, 0])

            @rope.move_down(1)
            expect(@rope.tail).to eq([1, -1])
          end

          it 'handles to tough case' do
            @rope = described_class.new([0, 1], [0, 0])

            @rope.move_down(1)
            expect(@rope.tail).to eq([0, 0])
          end
        end
      end

      describe 'corner cases (literally)' do
        it 'handles multiple moves where tail should stay put' do
          @rope = described_class.new([0, 0], [1, 0])

          @rope.move_down(1)
          expect(@rope.tail).to eq([1, 0])

          @rope.move_right(1)
          expect(@rope.tail).to eq([1, 0])

          @rope.move_right(1)
          expect(@rope.tail).to eq([1, 0])

          @rope.move_up(2)
          expect(@rope.tail).to eq([1, 0])

          @rope.move_left(2)
          expect(@rope.tail).to eq([1, 0])
        end
      end
    end
  end
end

RSpec.describe Year2022::Day09 do
  let(:input) { File.read(File.join(File.dirname(__FILE__), '../../../challenges/2022/09/input.txt')) }
  let(:example_input) do
    <<~EOF
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
    EOF
  end

  describe 'part 1' do
    it 'returns the correct result' do
      expect(described_class.part_1(example_input)).to eq(13)
    end

    it 'returns the correct real result' do
      expect(described_class.part_1(input)).to eq(5695)
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
