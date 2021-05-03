# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a king chess piece, inheriting from ChessPiece
class King < ChessPiece
  MOVES = [[1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1]].freeze

  def initialize(position, is_white)
    super(position, is_white)
    @token = is_white ? "\u2654" : "\u265A"
  end
end
