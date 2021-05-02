# Frozen_string_literal: true

# Class describing a basic chess piece
class ChessPiece
  MOVES = [].freeze
  def initialize(position, color)
    @position = position
    @color = color
  end

  def next_moves
    next_moves = self.class::MOVES.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    next_moves.delete_if { |move| move.include?(nil) }
  end
end
