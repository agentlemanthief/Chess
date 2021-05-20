# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/chessboard'

describe 'ChessBoard' do
  subject(:chess_board) { ChessBoard.new }

  describe '#initial_placement' do
    context 'Places all pieces in correct place for start of game' do
      context 'White pieces' do
        it 'Rooks' do
          expect(chess_board.board[0][0]).to be_a(Rook)
          expect(chess_board.board[0][0].is_white).to be(true)
          expect(chess_board.board[0][7]).to be_a(Rook)
          expect(chess_board.board[0][7].is_white).to be(true)
        end

        it 'Knights' do
          expect(chess_board.board[0][1]).to be_a(Knight)
          expect(chess_board.board[0][1].is_white).to be(true)
          expect(chess_board.board[0][6]).to be_a(Knight)
          expect(chess_board.board[0][6].is_white).to be(true)
        end

        it 'Bishops' do
          expect(chess_board.board[0][2]).to be_a(Bishop)
          expect(chess_board.board[0][2].is_white).to be(true)
          expect(chess_board.board[0][5]).to be_a(Bishop)
          expect(chess_board.board[0][5].is_white).to be(true)
        end

        it 'Queen' do
          expect(chess_board.board[0][3]).to be_a(Queen)
          expect(chess_board.board[0][3].is_white).to be(true)
        end

        it 'King' do
          expect(chess_board.board[0][4]).to be_a(King)
          expect(chess_board.board[0][3].is_white).to be(true)
        end

        it 'Pawns' do
          expect(chess_board.board[1][0]).to be_a(Pawn)
          expect(chess_board.board[1][0].is_white).to be(true)
          expect(chess_board.board[1][1]).to be_a(Pawn)
          expect(chess_board.board[1][1].is_white).to be(true)
          expect(chess_board.board[1][2]).to be_a(Pawn)
          expect(chess_board.board[1][2].is_white).to be(true)
          expect(chess_board.board[1][3]).to be_a(Pawn)
          expect(chess_board.board[1][3].is_white).to be(true)
          expect(chess_board.board[1][4]).to be_a(Pawn)
          expect(chess_board.board[1][4].is_white).to be(true)
          expect(chess_board.board[1][5]).to be_a(Pawn)
          expect(chess_board.board[1][5].is_white).to be(true)
          expect(chess_board.board[1][6]).to be_a(Pawn)
          expect(chess_board.board[1][6].is_white).to be(true)
          expect(chess_board.board[1][7]).to be_a(Pawn)
          expect(chess_board.board[1][7].is_white).to be(true)
        end
      end

      context 'Black pieces' do
        it 'Rooks' do
          expect(chess_board.board[7][0]).to be_a(Rook)
          expect(chess_board.board[7][0].is_white).to be(false)
          expect(chess_board.board[7][7]).to be_a(Rook)
          expect(chess_board.board[7][7].is_white).to be(false)
        end

        it 'Knights' do
          expect(chess_board.board[7][1]).to be_a(Knight)
          expect(chess_board.board[7][1].is_white).to be(false)
          expect(chess_board.board[7][6]).to be_a(Knight)
          expect(chess_board.board[7][6].is_white).to be(false)
        end

        it 'Bishops' do
          expect(chess_board.board[7][2]).to be_a(Bishop)
          expect(chess_board.board[7][2].is_white).to be(false)
          expect(chess_board.board[7][5]).to be_a(Bishop)
          expect(chess_board.board[7][5].is_white).to be(false)
        end

        it 'Queen' do
          expect(chess_board.board[7][3]).to be_a(Queen)
          expect(chess_board.board[7][3].is_white).to be(false)
        end

        it 'King' do
          expect(chess_board.board[7][4]).to be_a(King)
          expect(chess_board.board[7][3].is_white).to be(false)
        end

        it 'Pawns' do
          expect(chess_board.board[6][0]).to be_a(Pawn)
          expect(chess_board.board[6][0].is_white).to be(false)
          expect(chess_board.board[6][1]).to be_a(Pawn)
          expect(chess_board.board[6][1].is_white).to be(false)
          expect(chess_board.board[6][2]).to be_a(Pawn)
          expect(chess_board.board[6][2].is_white).to be(false)
          expect(chess_board.board[6][3]).to be_a(Pawn)
          expect(chess_board.board[6][3].is_white).to be(false)
          expect(chess_board.board[6][4]).to be_a(Pawn)
          expect(chess_board.board[6][4].is_white).to be(false)
          expect(chess_board.board[6][5]).to be_a(Pawn)
          expect(chess_board.board[6][5].is_white).to be(false)
          expect(chess_board.board[6][6]).to be_a(Pawn)
          expect(chess_board.board[6][6].is_white).to be(false)
          expect(chess_board.board[6][7]).to be_a(Pawn)
          expect(chess_board.board[6][7].is_white).to be(false)
        end
      end
    end
  end

  describe '#select_piece' do
    it 'Returns white king' do
      expect(chess_board.select_piece([0, 4])).to be_a(King)
      expect(chess_board.select_piece([0, 4]).is_white).to be(true)
    end
  end

  describe '#make_move' do
    it 'Moves white pawn from a2 [1, 0] to a3 [2, 0]' do
      chess_board.make_move([1, 0], [2, 0])
      expect(chess_board.board[2][0]).to be_a(Pawn)
      expect(chess_board.board[2][0].is_white).to be(true)
    end
  end

  describe '#update_piece_postition' do
    it 'Updates pawn piece @postition when moved from [1, 0] to [2, 0]' do
      pawn = chess_board.board[1][0]
      expect(pawn.position).to eq([1, 0])
      chess_board.make_move([1, 0], [2, 0])
      expect(pawn.position).to eq([2, 0])
    end
  end

  describe '#space_empty?' do
    it 'Returns true if selected space on board is empty' do
      expect(chess_board.space_empty?([2, 0])).to be(true)
    end

    it 'Returns falsey if selected space on board is not empty' do
      expect(chess_board.space_empty?([1, 0])).to be_falsey
    end
  end

  describe '#move_valid_for_piece?' do
    context 'Returns true or falsey if move co-ordinates are within selected pieces allowed moves' do
      it 'Returns true for pawn move from [1, 0] to [2, 0]' do
        expect(chess_board.move_valid_for_piece?([1, 0], [2, 0])).to be(true)
      end

      it 'Returns true for pawn move from [1, 0] to [3, 0]' do
        expect(chess_board.move_valid_for_piece?([1, 0], [3, 0])).to be(true)
      end

      it 'Returns true for pawn move from [1, 0] to [2, 1]' do
        expect(chess_board.move_valid_for_piece?([1, 0], [2, 1])).to be(true)
      end

      it 'Returns falsey for pawn move from [1, 0] to [4, 0]' do
        expect(chess_board.move_valid_for_piece?([1, 0], [4, 0])).to be_falsey
      end
    end
  end

  describe '#path_clear?' do
    it 'Returns true for a rook on a clear board moving from [0, 0] to [7, 0]' do
      r1w = Rook.new([0, 0], true)
      board_rook = [
        [r1w, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      chess_board.instance_variable_set(:@board, board_rook)
      expect(chess_board.path_clear?([0, 0], [7, 0])).to be(true)
    end

    it 'Returns falsey for an obstructed rook trying to move from [0, 0] to [7, 0]' do
      r1w = Rook.new([0, 0], true)
      p1w = Pawn.new([1, 0], true)
      board_rook_obstructed = [
        [r1w, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [p1w, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      chess_board.instance_variable_set(:@board, board_rook_obstructed)
      expect(chess_board.path_clear?([0, 0], [7, 0])).to be_falsey
    end
  end

  describe '#take_piece' do
    it 'Updates the board to move selected piece and removes chosen piece' do
      r1w = Rook.new([0, 0], true)
      p1b = Pawn.new([6, 0], false)
      take_test_before = [
        [r1w, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [p1b, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      take_test_after = [
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [r1w, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      chess_board.instance_variable_set(:@board, take_test_before)
      chess_board.take_piece([0, 0], [6, 0])
      expect(chess_board.board).to eq(take_test_after)
      expect(chess_board.board[6][0].position).to eq([6, 0])
      expect(chess_board.board[0][0]).to eq(' ')
    end
  end

  describe '#add_to_taken_array' do
    it 'Adds the taken piece to the appropriate array' do
      r1w = Rook.new([0, 0], true)
      p1b = Pawn.new([6, 0], false)
      take_test_before = [
        [r1w, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [p1b, ' ', ' ', ' ', ' ', ' ', ' ', ' '],
        [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
      ]
      chess_board.instance_variable_set(:@board, take_test_before)
      chess_board.take_piece([0, 0], [6, 0])
      expect(chess_board.taken_black_pieces).to eq([p1b])
    end
  end

  describe '#return_king' do
    it 'Returns the white king object' do
      white_king = chess_board.return_king(true)
      expect(white_king).to be_a(King)
      expect(white_king.is_white).to be(true)
    end
  end

  describe '#check?' do
    context 'Returns true in check' do
      it 'King piece is in check (single rook)' do
        kw = King.new([0, 4], true)
        r1b = Rook.new([7, 4], false)
        board_in_check = [
          [' ', ' ', ' ', ' ', kw, ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', r1b, ' ', ' ', ' ']
        ]
        chess_board.instance_variable_set(:@board, board_in_check)
        expect(chess_board.check?(true)).to eq(true)
      end
    end

    context 'Returns false when not in check' do
      it 'King piece is not in check (single rook)' do
        kw = King.new([0, 4], true)
        r1b = Rook.new([7, 3], false)
        board_in_check = [
          [' ', ' ', ' ', ' ', kw, ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', r1b, ' ', ' ', ' ', ' ']
        ]
        chess_board.instance_variable_set(:@board, board_in_check)
        expect(chess_board.check?(true)).to eq(false)
      end
    end
  end

  describe '#checkmate?' do
    context 'Returns true if checkmate' do
      it 'King in checkmate with two rooks' do
        kb = King.new([7, 2], false)
        r1w = Rook.new([6, 7], true)
        r2w = Rook.new([7, 6], true)
        checkmate_board = [
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', r1w],
          [' ', ' ', kb, ' ', ' ', ' ', r2w, ' ']
        ]
        chess_board.instance_variable_set(:@board, checkmate_board)
        expect(chess_board.checkmate?(false)).to eq(true)
      end
    end

    context 'Returns false if not in checkmate' do
      it 'King in check but not in checkmate' do
        r1w = Rook.new([0, 0], true)
        r2w = Rook.new([0, 7], true)
        kn1w = Knight.new([0, 1], true)
        kn2w = Knight.new([0, 6], true)
        b1w = Bishop.new([0, 2], true)
        b2w = Bishop.new([0, 5], true)
        kw = King.new([0, 4], true)
        qw = Queen.new([0, 3], true)
        p1w = Pawn.new([1, 0], true)
        p2w = Pawn.new([1, 1], true)
        p3w = Pawn.new([1, 2], true)
        p4w = Pawn.new([1, 3], true)
        p5w = Pawn.new([4, 4], true)
        p6w = Pawn.new([1, 5], true)
        p7w = Pawn.new([1, 6], true)
        p8w = Pawn.new([1, 7], true)

        r1b = Rook.new([3, 4], false)
        r2b = Rook.new([7, 7], false)
        kn1b = Knight.new([7, 1], false)
        kn2b = Knight.new([7, 6], false)
        b1b = Bishop.new([7, 2], false)
        b2b = Bishop.new([7, 5], false)
        kb = King.new([7, 4], false)
        qb = Queen.new([7, 3], false)
        p1b = Pawn.new([4, 0], false)
        p2b = Pawn.new([6, 1], false)
        p3b = Pawn.new([6, 2], false)
        p4b = Pawn.new([6, 3], false)
        p5b = Pawn.new([6, 4], false)
        p6b = Pawn.new([6, 5], false)
        p7b = Pawn.new([6, 6], false)
        p8b = Pawn.new([6, 7], false)
        not_checkmate_board = [
          [r1w, kn1w, b1w, qw, kw, b2w, kn2w, r2w],
          [p1w, p2w, p3w, p4w, ' ', p6w, p7w, p8w],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', r1b, ' ', ' ', ' '],
          [p1b, ' ', ' ', ' ', p5w, ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', p2b, p3b, p4b, p5b, p6b, p7b, p8b],
          [' ', kn1b, b1b, qb, kb, b2b, kn2b, r2b]
        ]
        chess_board.instance_variable_set(:@board, not_checkmate_board)
        expect(chess_board.checkmate?(true)).to eq(false)
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
