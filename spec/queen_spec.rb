# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/queen'

describe 'Queen' do
  subject(:queen) { Queen.new([0, 0], true) }

  describe '#next_moves' do
    context "Returns next available moves based on a queen's movement possibilities and current position" do
      it 'Returns expected moves from position [0, 0]' do
        expected_moves = [
          [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [7, 7], [1, 0], [2, 0], [3, 0], [4, 0],
          [5, 0], [6, 0], [7, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7]
        ]
        expect(queen.next_moves).to eq(expected_moves)
      end

      it 'Returns expected moves from position [3, 3]' do
        queen.position = [3, 3]
        expected_moves = [
          [4, 4], [5, 5], [6, 6], [7, 7], [4, 2], [5, 1], [6, 0], [2, 4], [1, 5],
          [0, 6], [2, 2], [1, 1], [0, 0], [4, 3], [5, 3], [6, 3], [7, 3], [3, 4],
          [3, 5], [3, 6], [3, 7], [2, 3], [1, 3], [0, 3], [3, 2], [3, 1], [3, 0]
        ]
        expect(queen.next_moves).to eq(expected_moves)
      end
    end
  end

  describe '#path' do
    it 'Returns an array of grid positions from start to destination showing traversal path for the piece' do
      expected = [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]]
      expect(queen.path([0, 0], [7, 0])).to eq(expected)
    end
  end
end

# rubocop:enable Metrics/BlockLength
