# Frozen_string_literal: true

# Class describing a basic chess piece
class ChessPiece
  attr_reader :token, :parent, :is_white
  attr_accessor :position

  MOVES = [].freeze
  MOVE_STEP = [].freeze

  def initialize(position, is_white, parent = nil)
    @position = position
    @is_white = is_white
    @token = nil
    @parent = parent
  end

  def next_moves(possible_moves = self.class::MOVES)
    next_moves_array = possible_moves.map do |move|
      move.each_with_index.map do |co_ord, i|
        co_ord + @position[i] unless (co_ord + @position[i]).negative? || (co_ord + @position[i]) > 7
      end
    end
    next_moves_array.delete_if { |move| move.include?(nil) }
  end

  def path(start, destination)
    current = make_tree(start, destination)
    history = []
    make_history(current, history, start)
    history.reverse!.shift
    history.pop
    history
  end

  def make_tree(start, destination)
    queue = [self.class.new(start, self.is_white)]
    current = queue.shift
    until current.position == destination
      current.next_moves(self.class::MOVE_STEP).each do |move|
        queue << self.class.new(move, self.is_white, current)
      end
      current = queue.shift
    end
    current
  end

  def make_history(current, history, start)
    until current.position == start
      history << current.position
      current = current.parent
    end
    history << current.position
  end
end
