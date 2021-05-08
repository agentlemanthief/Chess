# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a rook chess piece, inheriting from ChessPiece
class Rook < ChessPiece
  MOVES = [
    [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
    [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
    [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
    [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
  ].freeze
  MOVE_STEP = [[1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def initialize(position, is_white, parent = nil)
    super(position, is_white, parent)
    @token = is_white ? "\u2656" : "\u265C"
  end
end
