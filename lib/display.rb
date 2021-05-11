module Display
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  def print_helper(board_array_item)
    board_array_item == ' ' ? ' ' : board_array_item.token
  end
end
