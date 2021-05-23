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
    take_moves = take_moves_by_color
    available_moves = take_moves.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    available_moves.delete_if { |move| move.include?(nil) }
  end

  def take_moves_by_color
    if @is_white
      [[1, 1], [1, -1]]
    else
      [[-1, -1], [-1, 1]]
    end
  end

  def next_moves
    moves = moves_by_color
    next_moves = moves.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    next_moves.delete_if { |move| move.include?(nil) }
  end

  def moves_by_color
    if @is_white
      @first_move ? [[1, 0], [2, 0]] : [[1, 0]]
    else
      @first_move ? [[-1, 0], [-2, 0]] : [[-1, 0]]
    end
  end
end
