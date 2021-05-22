# Frozen_string_literal: true

require_relative '../lib/king'

describe 'King' do
  subject(:king) { King.new([0, 0], true) }

  describe '#next_moves' do
    context "Returns next available moves based on a king's movement possibilities and current position" do
      it 'Returns expected moves from position [0, 0]' do
        expected_moves = [[1, 0], [1, 1], [0, 1]]
        expect(king.next_moves).to eq(expected_moves)
      end

      it 'Returns expected moves from position [3, 3]' do
        king.position = [3, 3]
        expected_moves = [[4, 2], [4, 3], [4, 4], [3, 4], [2, 4], [2, 3], [2, 2], [3, 2]]
        expect(king.next_moves).to eq(expected_moves)
      end
    end
  end

  describe '#path' do
    it 'Returns an array of grid positions from start to destination showing traversal path for the piece' do
      expected = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]]
      expect(king.path([0, 0], [7, 7])).to eq(expected)
    end
  end
end
