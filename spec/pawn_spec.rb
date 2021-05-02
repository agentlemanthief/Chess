# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/pawn'

describe 'Pawn' do
  subject(:pawn) { Pawn.new([0, 0], 'black') }

  describe '#next_moves' do
    it 'Returns [[2, 0]] if position is [0, 0] and is the first move the piece has made' do
      next_moves = pawn.next_moves
      expect(next_moves).to eq([[2, 0]])
    end

    it 'Returns [[1, 0]] if position is [0, 0] and is not the first move the piece has made' do
      pawn.instance_variable_set(:@first_move, false)
      next_moves = pawn.next_moves
      expect(next_moves).to eq([[1, 0]])
    end
  end
end
