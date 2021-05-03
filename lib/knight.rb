# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a knight chess piece, inheriting from ChessPiece
class Knight < ChessPiece
  MOVES = [[1, 2], [2, 1], [-1, -2], [-2, -1], [1, -2], [-1, 2], [2, -1], [-2, 1]].freeze

  def initialize(position, is_white)
    super(position, is_white)
    @token = is_white ? "\u2658" : "\u265E"
  end
end
