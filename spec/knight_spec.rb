# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/knight'

describe 'Knight' do
  subject(:knight) { Knight.new([0, 0], 'black') }

  describe '#next_moves' do
    it 'Returns [[1, 2], [2, 1]] if position is [0, 0]' do
      next_moves = knight.next_moves
      expect(next_moves).to eq([[1, 2], [2, 1]])
    end
  end
end
