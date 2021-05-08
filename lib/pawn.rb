# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a pawn chess piece, inheriting from ChessPiece
class Pawn < ChessPiece
  attr_accessor :first_move

  TAKE_MOVES = [[1, 1], [-1, 1], [-1, -1], [1, -1]].freeze

  def initialize(position, is_white, parent = nil)
    super(position, is_white, parent)
    @first_move = true
    @token = is_white ? "\u2659" : "\u265F"
  end

  def position=(co_ord)
    @position = co_ord
    @first_move = false
  end

  def take_moves
    available_moves = TAKE_MOVES.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    available_moves.delete_if { |move| move.include?(nil) }
  end

  def next_moves(possible_moves = self.class::MOVES)
    if @is_white
      moves = @first_move ? [[1, 0], [2, 0]] : [[1, 0]]
    else
      moves = @first_move ? [[-1, 0], [-2, 0]] : [[-1, 0]]
    end
    next_moves = moves.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    next_moves.delete_if { |move| move.include?(nil) }
  end
end
