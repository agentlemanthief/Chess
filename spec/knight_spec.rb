# Frozen_string_literal: true

require_relative '../lib/knight'

describe 'Knight' do
  subject(:knight) { Knight.new([0, 0], true) }

  describe '#next_moves' do
    context "Returns next available moves based on a knight's movement possibilities and current position" do
      it 'Returns expected moves from position [0, 0]' do
        expected_moves = [[1, 2], [2, 1]]
        expect(knight.next_moves).to eq(expected_moves)
      end

      it 'Returns expected moves from position [3, 3]' do
        knight.position = [3, 3]
        expected_moves = [[4, 5], [5, 4], [2, 1], [1, 2], [4, 1], [2, 5], [5, 2], [1, 4]]
        expect(knight.next_moves).to eq(expected_moves)
      end
    end
  end

  describe '#path' do
    it 'Returns an array of grid positions from start to destination showing traversal path for the piece' do
      expected = [[1, 2], [2, 4], [3, 6], [5, 7], [6, 5]]
      expect(knight.path([0, 0], [7, 7])).to eq(expected)
    end
  end
end
