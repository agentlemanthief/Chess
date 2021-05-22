# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/pawn'

describe 'Pawn' do
  subject(:pawn) { Pawn.new([0, 0], true) }

  describe '#next_moves' do
    context "Returns next available moves based on a white pawn's movement possibilities and current position" do
      it 'Returns expected moves from position [0, 0] if it is the first move' do
        expected = [[1, 0], [2, 0]]
        expect(pawn.next_moves).to eq(expected)
      end

      it 'Returns expected moves from position [0, 0] if it is NOT the first move' do
        pawn.instance_variable_set(:@first_move, false)
        expected = [[1, 0]]
        expect(pawn.next_moves).to eq(expected)
      end

      it 'Returns expected moves from position [3, 3] if it is NOT the first move' do
        pawn.instance_variable_set(:@first_move, false)
        pawn.position = [3, 3]
        expected = [[4, 3]]
        expect(pawn.next_moves).to eq(expected)
      end
    end
  end

  describe '#take_moves' do
    context 'Returns possible taking moves for white pawn' do
      it 'Returns possible taking moves for a white pawn at position [0, 0]' do
        expected = [[1, 1]]
        expect(pawn.take_moves).to eq(expected)
      end

      it 'Returns possible taking moves for a white pawn at position [3, 3]' do
        pawn.position = [3, 3]
        expected = [[4, 4], [4, 2]]
        expect(pawn.take_moves).to eq(expected)
      end
    end

    context 'Returns possible taking moves for black pawn' do
      before do
        pawn.instance_variable_set(:@is_white, false)
      end

      it 'Returns possible taking moves for a black pawn at position [7, 0]' do
        pawn.position = [7, 0]
        expected = [[6, 1]]
        expect(pawn.take_moves).to eq(expected)
      end

      it 'Returns possible taking moves for a black pawn at position [4, 3]' do
        pawn.position = [4, 3]
        expected = [[3, 2], [3, 4]]
        expect(pawn.take_moves).to eq(expected)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
