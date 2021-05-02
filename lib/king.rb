# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a knight chess piece, inheriting from ChessPiece
class King < ChessPiece
  MOVES = [[1, -1], [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1]].freeze
end
