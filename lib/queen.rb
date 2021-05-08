# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a queen chess piece, inheriting from ChessPiece
class Queen < ChessPiece
  MOVES = [
    [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [7, 7],
    [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [7, -7],
    [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-7, 7],
    [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-7, -7],
    [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
    [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
    [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
    [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]
  ].freeze
  MOVE_STEP = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 0], [0, 1], [-1, 0], [0, -1]].freeze

  def initialize(position, is_white, parent = nil)
    super(position, is_white, parent)
    @token = is_white ? "\u2655" : "\u265B"
  end
end
