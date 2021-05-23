# Frozen_string_literal: true

# Module containing display elements for the chess game
module Display
  # rubocop:disable Metrics/AbcSize

  INTRO = <<~'INTRO'
    /\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\
    \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/

      Welcome to Chess!

      Chess is a recreational and competitive board game played between two players.
      It is sometimes called Western or international chess to distinguish it from
      related games such as xiangqi. The current form of the game emerged in
      Southern Europe during the second half of the 15th century after evolving from
      similar, much older games of Indian and Persian origin. Today, chess is one of
      the world's most popular games, played by millions of people worldwide at home,
      in clubs, online, by correspondence, and in tournaments.

      Chess is an abstract strategy game and involves no hidden information. It is
      played on a square chessboard with 64 squares arranged in an eight-by-eight
      grid. At the start, each player (one controlling the white pieces, the other
      controlling the black pieces) controls sixteen pieces: one king, one queen,
      two rooks, two knights, two bishops, and eight pawns. The object of the game
      is to checkmate the opponent's king, whereby the king is under immediate
      attack (in "check") and there is no way for it to escape. There are also
      several ways a game can end in a draw.

      You can save your game at any time by typing 'save'. You can then carry on
      where you left off next time.

      Good luck players!

      Press any key to continue...

    /\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\_/\
    \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
  INTRO

  def display_board
    puts <<-BOARD

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
  end
  # rubocop:enable Metrics/AbcSize

  def print_helper(board_array_item)
    board_array_item == ' ' ? ' ' : board_array_item.token
  end
end
