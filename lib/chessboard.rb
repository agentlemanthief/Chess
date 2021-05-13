# Frozen_string_literal: true

require_relative 'king'
require_relative 'queen'
require_relative 'bishop'
require_relative 'knight'
require_relative 'rook'
require_relative 'pawn'
require_relative 'display'

# Class describing a chessboard and the methods required to manipulate chess pieces/check for check/checkmate
class ChessBoard
  attr_reader :taken_black_pieces, :taken_white_pieces
  attr_accessor :board

  include Display

  def initialize
    @board = Array.new(8) { Array.new(8, ' ') }
    @taken_white_pieces = []
    @taken_black_pieces = []
    initial_placement
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

  def select_piece(co_ord)
    @board[co_ord[0]][co_ord[1]]
  end

  def make_move(piece_co_ord, destination)
    @board[destination[0]][destination[1]] = select_piece(piece_co_ord)
    @board[piece_co_ord[0]][piece_co_ord[1]] = ' '
    update_piece_position(destination)
  end

  def update_piece_position(destination)
    select_piece(destination).position = destination
  end

  def space_empty?(destination)
    return true if @board[destination[0]][destination[1]] == ' '
  end

  def move_valid_for_piece?(piece_co_ord, destination)
    if select_piece(piece_co_ord).next_moves.include?(destination)
      true
    elsif select_piece(piece_co_ord).is_a?(Pawn)
      return true if select_piece(piece_co_ord).take_moves.include?(destination)
    end
  end

  def path_clear?(piece_co_ord, destination)
    return true if select_piece(piece_co_ord).is_a?(Pawn)

    path = select_piece(piece_co_ord).path(piece_co_ord, destination)
    path.map! { |co_ord| select_piece(co_ord).is_a?(ChessPiece) }
    !path.include?(true)
  end

  def take_piece(piece_co_ord, destination)
    add_to_taken_array(destination)
    @board[destination[0]][destination[1]] = select_piece(piece_co_ord)
    @board[piece_co_ord[0]][piece_co_ord[1]] = ' '
    update_piece_position(destination)
  end

  def add_to_taken_array(destination)
    if select_piece(destination).is_white
      @taken_white_pieces << select_piece(destination)
    else
      @taken_black_pieces << select_piece(destination)
    end
  end

  def return_king(is_white)
    king = @board.map do |array|
      array.select { |square| square.is_a?(King) && square.is_white == is_white }
    end
    king = king.flatten[0]
  end

  def check_each_piece_for_check(king, is_white)
    result = @board.map do |array|
      array.map do |square|
        if square.is_a?(ChessPiece) && !square.is_a?(Pawn) && square.is_white != is_white
          move_valid_for_piece?(square.position, king.position) && path_clear?(square.position, king.position)
        elsif square.is_a?(ChessPiece) && square.is_a?(Pawn) && square.is_white != is_white
          square.take_moves.include?(king.position)
        end
      end
    end
    result.any? { |array| array.include?(true) }
  end

  def check?(is_white)
    king = return_king(is_white)
    check_each_piece_for_check(king, is_white)
  end

  def check_mate?(is_white)
    king = return_king(is_white)
    start_king_position = king.position

    results = king.next_moves.map do |move|
      if space_empty?(move)
        make_move(king.position, move)
        check_each_piece_for_check(king, is_white)
      end
    end
    make_move(king.position, start_king_position) if king.position != start_king_position
    results.delete(nil)
    results.all?(true)
  end
end

# board.board = [
#   [Rook.new([0, 0], true), Knight.new([0, 1], true), Bishop.new([0, 2], true), Queen.new([0, 3], true), King.new([0, 4], true), Bishop.new([0, 5], true), Knight.new([0, 6], true), Rook.new([0, 7], true)],
#   [Pawn.new([1, 0], true), Pawn.new([1, 1], true), Pawn.new([1, 2], true), Pawn.new([1, 3], true), ' ', Pawn.new([1, 5], true), Pawn.new([1, 6], true), Pawn.new([1, 7], true)],
#   [' ', ' ', ' ', ' ', Rook.new([2, 4], false), ' ', ' ', ' '],
#   [' ', ' ', ' ', ' ', Pawn.new([3, 4], true), ' ', ' ', ' '],
#   [Pawn.new([4, 0], false), ' ', ' ', ' ', ' ', ' ', ' ', ' '],
#   [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
#   [' ', Pawn.new([6, 1], false), Pawn.new([6, 2], false), Pawn.new([6, 3], false), Pawn.new([6, 4], false), Pawn.new([6, 5], false), Pawn.new([6, 6], false), Pawn.new([6, 7], false)],
#   [' ', Knight.new([7, 1], false), Bishop.new([7, 2], false), Queen.new([7, 3], false), King.new([7, 4], false), Bishop.new([7, 5], false), Knight.new([7, 6], false), Rook.new([7, 7], false)]
# ]
