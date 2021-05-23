# Frozen_string_literal: true

require 'io/console'
require 'yaml'
require_relative 'chessboard'
require_relative 'display'

# rubocop:disable Metrics/ClassLength

# Class to determine game flow and get inputs
class Game
  include Display

  def initialize(chess_board = ChessBoard.new)
    @chess_board = chess_board
    @white_player_turn = true
  end

  def play_game
    intro
    load_game
    @chess_board.display_board
    game_loop
    puts 'Checkmate!'
    puts "Congratulations!! #{winner} player wins the game!!\n\n"
  end

  def game_loop
    loop do
      puts "#{@white_player_turn ? 'White' : 'Black'} move.\n\n"
      move_piece(@white_player_turn)
      @chess_board.display_board
      puts "#{@white_player_turn ? 'Black' : 'White'} King is in check" if @chess_board.check?(!@white_player_turn)
      break if game_over?(!@white_player_turn)

      @white_player_turn = @white_player_turn ? false : true
    end
  end

  def intro
    puts Display::INTRO
    $stdin.getch
  end

  def move_input
    input = validate(gets.chomp.upcase)
    want_to_save(input)
  end

  def validate(input)
    return input if input.match?(/^[A-H][1-8]$|^\e$|^SAVE$/)

    puts "Please enter in the format: 'a1', 'esc' to change piece selection or 'save' to save the game."
    validate(gets.chomp.upcase)
  end

  def move_piece(is_white_piece)
    initial_text(is_white_piece)
    piece_co_ord = return_correct_piece_co_ordinate(is_white_piece)
    puts 'Please choose where to move to.'
    destination = return_valid_destination(is_white_piece, piece_co_ord)
    make_or_take(piece_co_ord, destination, is_white_piece)
  end

  def initial_text(is_white_piece)
    if @chess_board.check?(is_white_piece)
      puts 'Please make a move out of check.'
    else
      puts 'Please choose a piece to move.'
    end
  end

  def return_correct_piece_co_ordinate(is_white_piece)
    piece_co_ord = return_co_ord
    while @chess_board.space_empty?(piece_co_ord) || @chess_board.select_piece(piece_co_ord).is_white != is_white_piece
      puts 'Please pick one of your pieces, try again...'
      piece_co_ord = return_co_ord
    end
    piece_co_ord
  end

  def return_valid_destination(is_white_piece, piece_co_ord)
    destination = return_co_ord
    return move_piece(is_white_piece) if destination == "\e"

    until @chess_board.move_valid_for_piece?(piece_co_ord,
                                             destination) && @chess_board.path_clear?(piece_co_ord, destination)
      puts 'Choose another move'
      destination = return_co_ord
    end
    destination
  end

  def make_or_take(piece_co_ord, destination, is_white_piece)
    if @chess_board.space_empty?(destination)
      @chess_board.make_move(piece_co_ord, destination)
      move_piece(is_white_piece) if @chess_board.check?(is_white_piece)
    elsif @chess_board.select_piece(piece_co_ord).is_white != @chess_board.select_piece(destination).is_white
      take_piece_logic(piece_co_ord, destination, is_white_piece)
    else
      puts 'You cannot take your own pieces! Try another move.'
      move_piece(is_white_piece)
    end
  end

  def take_piece_logic(piece_co_ord, destination, is_white_piece)
    if @chess_board.select_piece(piece_co_ord).is_a?(Pawn)
      if @chess_board.select_piece(piece_co_ord).take_moves.include?(destination)
        @chess_board.take_piece(piece_co_ord, destination)
      else
        puts "You can't take that way, try another move."
        move_piece(is_white_piece)
      end
    else
      @chess_board.take_piece(piece_co_ord, destination)
    end
  end

  def return_co_ord
    alpha = %w[A B C D E F G H]
    move_split = move_input.chars
    if move_split.include?("\e")
      puts 'You changed your mind, choose another piece to move.'
      return "\e"
    end
    temp_a = move_split[1].to_i - 1
    temp_b = alpha.index(move_split[0])
    [temp_a, temp_b]
  end

  def game_over?(is_white)
    return true if @chess_board.check?(is_white) && @chess_board.checkmate?(is_white)
  end

  def winner
    @chess_board.checkmate?(false) ? 'White' : 'Black'
  end

  def want_to_save(input)
    return input unless input == 'SAVE'

    save
    exit
  end

  def save
    File.open('save_game.yaml', 'w') do |file|
      file.puts(to_yaml)
    end
  end

  def to_yaml
    YAML.dump(
      'chess_board' => @chess_board,
      'white_player_turn' => @white_player_turn
    )
  end

  def from_yaml(file)
    data = YAML.safe_load(File.read(file), permitted_classes: [ChessBoard, Rook, Knight, King, Queen, Bishop, Pawn],
                                           aliases: true)
    @chess_board = data['chess_board']
    @white_player_turn = data['white_player_turn']
  end

  def load_game
    return unless File.exist?('save_game.yaml')

    puts "\nWould you like to continue where you left off last time? (Enter: \"y\" or \"n\")"
    answer = gets.chomp.upcase
    return unless answer == 'Y'

    File.open('save_game.yaml', 'r') do |file|
      from_yaml(file)
    end
    File.delete('save_game.yaml')
  end
end

# rubocop:enable Metrics/ClassLength
