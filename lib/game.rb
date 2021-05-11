# Frozen_string_literal: true

require_relative 'chessboard'

# Class to determine game flow
class Game
  def initialize
    @chess_board = ChessBoard.new
  end

  def game_loop
    # intro
    @chess_board.initial_placement
    @chess_board.display_board
    loop do

      puts 'White move.'
      @chess_board.move_piece
      @chess_board.display_board
      puts 'Black King in check' if @chess_board.check?(false)
      break if game_over?(false)

      puts 'Black move.'
      @chess_board.move_piece
      @chess_board.display_board
      puts 'White King in check' if @chess_board.check?(true)
      break if game_over?(true)

    end
  end

  def game_over?(is_white)
    return true if @chess_board.check?(is_white) && @chess_board.check_mate?(is_white)
  end
end

game = Game.new

game.game_loop
