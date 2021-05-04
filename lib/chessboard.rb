# Frozen_string_literal: true

require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'

# Class describing a chessboard and its methods
class ChessBoard
  attr_accessor :board

  def initialize
    @board = Array.new(8) { Array.new(8, ' ') }
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def display_board
    board = <<-BOARD

        +---+---+---+---+---+---+---+---+
      8 | #{print_helper(@board[7][0])} | #{print_helper(@board[7][1])} | #{print_helper(@board[7][2])} | #{print_helper(@board[7][3])} | #{print_helper(@board[7][4])} | #{print_helper(@board[7][5])} | #{print_helper(@board[7][6])} | #{print_helper(@board[7][7])} |
        +---+---+---+---+---+---+---+---+
      7 | #{print_helper(@board[6][0])} | #{print_helper(@board[6][1])} | #{print_helper(@board[6][2])} | #{print_helper(@board[6][3])} | #{print_helper(@board[6][4])} | #{print_helper(@board[6][5])} | #{print_helper(@board[6][6])} | #{print_helper(@board[6][7])} |
        +---+---+---+---+---+---+---+---+
      6 | #{print_helper(@board[5][0])} | #{print_helper(@board[5][1])} | #{print_helper(@board[5][2])} | #{print_helper(@board[5][3])} | #{print_helper(@board[5][4])} | #{print_helper(@board[5][5])} | #{print_helper(@board[5][6])} | #{print_helper(@board[5][7])} |
        +---+---+---+---+---+---+---+---+
      5 | #{print_helper(@board[4][0])} | #{print_helper(@board[4][1])} | #{print_helper(@board[4][2])} | #{print_helper(@board[4][3])} | #{print_helper(@board[4][4])} | #{print_helper(@board[4][5])} | #{print_helper(@board[4][6])} | #{print_helper(@board[4][7])} |
        +---+---+---+---+---+---+---+---+
      4 | #{print_helper(@board[3][0])} | #{print_helper(@board[3][1])} | #{print_helper(@board[3][2])} | #{print_helper(@board[3][3])} | #{print_helper(@board[3][4])} | #{print_helper(@board[3][5])} | #{print_helper(@board[3][6])} | #{print_helper(@board[3][7])} |
        +---+---+---+---+---+---+---+---+
      3 | #{print_helper(@board[2][0])} | #{print_helper(@board[2][1])} | #{print_helper(@board[2][2])} | #{print_helper(@board[2][3])} | #{print_helper(@board[2][4])} | #{print_helper(@board[2][5])} | #{print_helper(@board[2][6])} | #{print_helper(@board[2][7])} |
        +---+---+---+---+---+---+---+---+
      2 | #{print_helper(@board[1][0])} | #{print_helper(@board[1][1])} | #{print_helper(@board[1][2])} | #{print_helper(@board[1][3])} | #{print_helper(@board[1][4])} | #{print_helper(@board[1][5])} | #{print_helper(@board[1][6])} | #{print_helper(@board[1][7])} |
        +---+---+---+---+---+---+---+---+
      1 | #{print_helper(@board[0][0])} | #{print_helper(@board[0][1])} | #{print_helper(@board[0][2])} | #{print_helper(@board[0][3])} | #{print_helper(@board[0][4])} | #{print_helper(@board[0][5])} | #{print_helper(@board[0][6])} | #{print_helper(@board[0][7])} |
        +---+---+---+---+---+---+---+---+
          a   b   c   d   e   f   g   h

    BOARD
    puts board
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def print_helper(board_array_item)
    board_array_item == ' ' ? ' ' : board_array_item.token
  end

  def initial_placement
    white_placement
    black_placement
  end

  def white_placement
    place_king(0, true)
    place_queen(0, true)
    place_bishop(0, true)
    place_knight(0, true)
    place_rook(0, true)
    place_pawns(1, true)
  end

  def black_placement
    place_king(7, false)
    place_queen(7, false)
    place_bishop(7, false)
    place_knight(7, false)
    place_rook(7, false)
    place_pawns(6, false)
  end

  def place_king(co_ord, is_white)
    @board[co_ord][4] = King.new([co_ord, 4], is_white)
  end

  def place_queen(co_ord, is_white)
    @board[co_ord][3] = Queen.new([co_ord, 3], is_white)
  end

  def place_bishop(co_ord, is_white)
    @board[co_ord][2] = Bishop.new([co_ord, 2], is_white)
    @board[co_ord][5] = Bishop.new([co_ord, 5], is_white)
  end

  def place_knight(co_ord, is_white)
    @board[co_ord][1] = Knight.new([co_ord, 1], is_white)
    @board[co_ord][6] = Knight.new([co_ord, 6], is_white)
  end

  def place_rook(co_ord, is_white)
    @board[co_ord][0] = Rook.new([co_ord, 0], is_white)
    @board[co_ord][7] = Rook.new([co_ord, 7], is_white)
  end

  def place_pawns(co_ord, is_white)
    @board[co_ord].map!.with_index { |_space, i| Pawn.new([co_ord, i], is_white) }
  end

  def move_input
    puts "Please choose a cell, e.g. 'a1'"
    validate(gets.chomp.upcase)
  end

  def validate(input)
    return input if input.match?(/^[A-Z][1-8]$/)

    puts "Please enter in the format: 'a1'"
    validate(gets.chomp.upcase)
  end

  def move_piece
    piece_coord = return_coord
    destination = return_coord
    @board[piece_coord[0]][piece_coord[1]], @board[destination[0]][destination[1]] =
      @board[destination[0]][destination[1]], @board[piece_coord[0]][piece_coord[1]]
  end

  def return_coord
    alpha = %w[A B C D E F G H]
    move_split = move_input.split('')
    temp_a = move_split[1].to_i - 1
    temp_b = alpha.index(move_split[0])
    [temp_a, temp_b]
  end
end

board = ChessBoard.new

board.display_board

board.initial_placement

board.display_board

board.move_piece

board.display_board
