# Frozen_string_literal: true

require_relative '../lib/bishop'

describe 'Bishop' do
  subject(:bishop) { Bishop.new([0, 0], true) }

  describe '#next_moves' do
    context "Returns next available moves based on a bishop's movement possibilities and current position" do
      it 'Returns expected moves from position [0, 0]' do
        expected_moves = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [7, 7]]
        expect(bishop.next_moves).to eq(expected_moves)
      end

      it 'Returns expected moves from position [3, 3]' do
        bishop.position = [3, 3]
        expected_moves = [
          [4, 4], [5, 5], [6, 6], [7, 7], [4, 2], [5, 1], [6, 0], [2, 4], [1, 5], [0, 6], [2, 2], [1, 1], [0, 0]
        ]
        expect(bishop.next_moves).to eq(expected_moves)
      end
    end
  end

  describe '#path' do
    it 'Returns an array of grid positions from start to destination showing traversal path for the piece' do
      expected = [[1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6]]
      expect(bishop.path([0, 0], [7, 7])).to eq(expected)
    end
  end
end
