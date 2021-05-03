# Frozen_string_literal: true

require_relative 'chess_piece'

# Class describing a pawn chess piece, inheriting from ChessPiece
class Pawn < ChessPiece
  attr_accessor :first_move

  def initialize(position, is_white)
    super(position, is_white)
    @first_move = true
    @token = is_white ? "\u2659" : "\u265F"
  end

  def next_moves
    moves = @first_move ? [[1, 0], [2, 0]] : [[1, 0]]
    next_moves = moves.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    next_moves.delete_if { |move| move.include?(nil) }
  end
end
