# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/king'

describe 'King' do
  subject(:king) { King.new([0, 0], 'black') }

  describe '#next_moves' do
    it 'Returns [[1, 0], [1, 1], [0, 1]] if position is [0, 0]' do
      next_moves = king.next_moves
      expect(next_moves).to eq([[1, 0], [1, 1], [0, 1]])
    end
  end
end
