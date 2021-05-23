# Frozen_string_literal: true

# rubocop:disable Metrics/BlockLength

require_relative '../lib/game'

describe 'Game' do
  subject(:game) { Game.new }
  let(:chess_board) { instance_double('chess_board') }

  describe '#game_loop' do
    context 'When #game_over? true first off' do
      before do
        allow(game).to receive(:game_over?).and_return(true)
      end

      it 'Calls #move_piece once' do
        expect(game).to receive(:move_piece).once
        game.game_loop
      end
    end

    context 'When #game_over? false then true first off' do
      before do
        allow(game).to receive(:game_over?).and_return(false, true)
      end

      it 'Calls #move_piece twice' do
        expect(game).to receive(:move_piece).twice
        game.game_loop
      end
    end

    context 'When #game_over? is false four times' do
      before do
        allow(game).to receive(:game_over?).and_return(false, false, false, false, true)
      end

      it 'Calls #move_piece five times' do
        expect(game).to receive(:move_piece).exactly(5).times
        game.game_loop
      end
    end
  end

  describe '#initial_text' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    it "Returns 'Please choose a piece to move.' if not in check" do
      allow(chess_board).to receive(:check?).and_return(false)
      output = 'Please choose a piece to move.'
      expect(game).to receive(:puts).with(output)
      game.initial_text(true)
    end

    it "Returns 'Please make a move out of check.' if not in check" do
      allow(chess_board).to receive(:check?).and_return(true)
      output = 'Please make a move out of check.'
      expect(game).to receive(:puts).with(output)
      game.initial_text(true)
    end
  end

  describe '#return_correct_piece_co_ordinate' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    it 'Returns co-ordinates if they are a ChessPiece of the correct colour' do
      allow(game).to receive(:return_co_ord).and_return([1, 0])
      allow(chess_board).to receive(:space_empty?).and_return(false)
      allow(chess_board).to receive_message_chain(:select_piece, :is_white) { true }
      expect(game.return_correct_piece_co_ordinate(true)).to eq([1, 0])
    end

    it 'Returns error message and reprompts for input if space is not empty once' do
      allow(game).to receive(:return_co_ord).and_return([1, 0])
      allow(chess_board).to receive(:space_empty?).and_return(true, false)
      allow(chess_board).to receive_message_chain(:select_piece, :is_white) { true }
      message = 'Please pick one of your pieces, try again...'
      expect(game).to receive(:puts).with(message).once
      game.return_correct_piece_co_ordinate(true)
    end

    it 'Returns error message and reprompts for input if space is not empty twice' do
      allow(game).to receive(:return_co_ord).and_return([1, 0])
      allow(chess_board).to receive(:space_empty?).and_return(true, true, false)
      allow(chess_board).to receive_message_chain(:select_piece, :is_white) { true }
      message = 'Please pick one of your pieces, try again...'
      expect(game).to receive(:puts).with(message).twice
      game.return_correct_piece_co_ordinate(true)
    end

    it 'Returns error message and reprompts if selected piece is not of the correct colour' do
      allow(game).to receive(:return_co_ord).and_return([1, 0])
      allow(chess_board).to receive(:space_empty?).and_return(false)
      allow(chess_board).to receive(:select_piece).and_return(Pawn.new([1, 0], false), Pawn.new([1, 0], true))
      message = 'Please pick one of your pieces, try again...'
      expect(game).to receive(:puts).with(message)
      game.return_correct_piece_co_ordinate(true)
    end
  end

  describe '#return_valid_destination' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    it 'Returns destination co-ordinate if it is a valid move for the selected piece' do
      allow(game).to receive(:return_co_ord).and_return([2, 0])
      allow(chess_board).to receive(:move_valid_for_piece?).and_return(true)
      allow(chess_board).to receive(:path_clear?).and_return(true)
      expect(game.return_valid_destination(true, [1, 0])).to eq([2, 0])
    end

    it 'Calls #move_piece if the esc key is entered' do
      allow(game).to receive(:return_co_ord).and_return("\e")
      allow(game).to receive(:move_piece)
      expect(game).to receive(:move_piece).once
      game.return_valid_destination(true, [1, 0])
    end

    it 'Returns error message and reprompts if move is not valid for piece once' do
      allow(game).to receive(:return_co_ord).and_return([4, 0])
      allow(chess_board).to receive(:move_valid_for_piece?).and_return(false, true)
      allow(chess_board).to receive(:path_clear?).and_return(true)
      message = 'Choose another move'
      expect(game).to receive(:puts).with(message)
      game.return_valid_destination(true, [1, 0])
    end

    it 'Returns error message and reprompts if move is path is not clear once' do
      allow(game).to receive(:return_co_ord).and_return([4, 0])
      allow(chess_board).to receive(:move_valid_for_piece?).and_return(true)
      allow(chess_board).to receive(:path_clear?).and_return(false, true)
      message = 'Choose another move'
      expect(game).to receive(:puts).with(message)
      game.return_valid_destination(true, [1, 0])
    end
  end

  describe '#make_or_take' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    it 'Calls ChessBoard#make_move if space is empty' do
      allow(chess_board).to receive(:space_empty?).and_return(true)
      allow(chess_board).to receive(:make_move)
      allow(chess_board).to receive(:check?).and_return(false)
      expect(chess_board).to receive(:make_move)
      game.make_or_take([1, 0], [2, 0], true)
    end

    it 'Calls #move_piece if player is in check' do
      allow(chess_board).to receive(:space_empty?).and_return(true)
      allow(chess_board).to receive(:make_move)
      allow(chess_board).to receive(:check?).and_return(true)
      expect(game).to receive(:move_piece)
      game.make_or_take([1, 0], [2, 0], true)
    end

    it 'Calls #take_piece_logic if destination is not empty and is a piece of opposite colour' do
      allow(chess_board).to receive(:space_empty?).and_return(false)
      allow(chess_board).to receive(:select_piece).and_return(King.new([1, 0], false), King.new([2, 0], true))
      expect(game).to receive(:take_piece_logic)
      game.make_or_take([1, 0], [2, 0], true)
    end

    it 'Returns error message and calls #move_piece if none of the above are true' do
      allow(chess_board).to receive(:space_empty?).and_return(false)
      allow(chess_board).to receive(:select_piece).and_return(King.new([1, 0], true), Queen.new([2, 0], true))
      message = 'You cannot take your own pieces! Try another move.'
      expect(game).to receive(:puts).with(message)
      expect(game).to receive(:move_piece)
      game.make_or_take([1, 0], [2, 0], true)
    end
  end

  describe '#take_piece_logic' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    context 'If piece is a pawn' do
      it 'Calls ChessBoard#take_piece if take_move is allowed' do
        allow(chess_board).to receive(:select_piece).and_return(Pawn.new([1, 0], true))
        expect(chess_board).to receive(:take_piece)
        game.take_piece_logic([1, 0], [2, 1], true)
      end

      it 'Returns error message and calls #move_piece if take move is not allowed' do
        allow(chess_board).to receive(:select_piece).and_return(Pawn.new([1, 0], true))
        message = "You can't take that way, try another move."
        expect(game).to receive(:puts).with(message)
        expect(game).to receive(:move_piece)
        game.take_piece_logic([1, 0], [2, 0], true)
      end
    end

    context 'If piece is not a pawn' do
      it 'Calls ChessBoard#take_piece' do
        allow(chess_board).to receive(:select_piece).and_return(King.new([1, 0], true))
        expect(chess_board).to receive(:take_piece)
        game.take_piece_logic([1, 0], [2, 0], true)
      end
    end
  end

  describe '#game_over?' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    it 'Returns true if ChessBoard#check is true and ChessBoard#checkmate? is true' do
      allow(chess_board).to receive(:check?).with(false).and_return(true)
      allow(chess_board).to receive(:checkmate?).with(false).and_return(true)
      expect(game.game_over?(false)).to be(true)
    end

    it 'Does not return true if ChessBoard#checkmate? is false' do
      allow(chess_board).to receive(:check?).with(false).and_return(true)
      allow(chess_board).to receive(:checkmate?).with(false).and_return(false)
      expect(game.game_over?(false)).to_not be(true)
    end
  end

  describe '#move_input' do
    it "Returns input if valid and not 'SAVE'" do
      input = 'A1'
      allow(game).to receive(:gets).and_return(input)
      expect(game.move_input).to eq(input)
    end
  end

  describe '#validate' do
    context 'Returns input if valid' do
      it "Returns input if input is 'A1'" do
        input = 'A1'
        expect(game.validate(input)).to eq(input)
      end

      it "Returns input if input is 'B1'" do
        input = 'B1'
        expect(game.validate(input)).to eq(input)
      end

      it "Returns input if input is 'SAVE'" do
        input = 'SAVE'
        expect(game.validate(input)).to eq(input)
      end

      it 'Returns input if input is escape char' do
        input = "\e"
        expect(game.validate(input)).to eq(input)
      end

      it 'Calls #validate if input does not match' do
        allow(game).to receive(:gets).and_return('I1')
        expect(game).to receive(:validate).once
        game.validate(:gets)
      end
    end
  end

  describe '#return_co_ord' do
    context 'Returns co-ordinates in array' do
      it "Returns [0, 0] if 'A1' is input" do
        allow(game).to receive(:move_input).and_return('A1')
        output = [0, 0]
        expect(game.return_co_ord).to eq(output)
      end

      it "Returns [0, 1] if 'B1' is input" do
        allow(game).to receive(:move_input).and_return('B1')
        output = [0, 1]
        expect(game.return_co_ord).to eq(output)
      end

      it 'Returns escape character and message if #move_input is escape character' do
        allow(game).to receive(:move_input).and_return("\e")
        output = "\e"
        expect(game.return_co_ord).to eq(output)
      end

      it 'Returns changed mind message if #move_input is escape character' do
        allow(game).to receive(:move_input).and_return("\e")
        message = 'You changed your mind, choose another piece to move.'
        expect(game).to receive(:puts).with(message)
        game.return_co_ord
      end
    end
  end

  describe '#winner' do
    before do
      game.instance_variable_set(:@chess_board, chess_board)
    end

    it "Returns 'White' if black is in checkmate" do
      allow(chess_board).to receive(:checkmate?).with(false).and_return(true)
      expect(game.winner).to eq('White')
    end

    it "Returns 'Black' if white is in checkmate (assumed)" do
      allow(chess_board).to receive(:checkmate?).with(false).and_return(false)
      expect(game.winner).to eq('Black')
    end
  end

  describe '#want_to_save' do
    it "Returns input if it does not equal 'SAVE'" do
      input = 'A1'
      expect(game.want_to_save(input)).to eq(input)
    end

    it "Calls #save if input equals 'SAVE'" do
      input = 'SAVE'
      expect(game).to receive(:exit)
      expect(game).to receive(:save)
      game.want_to_save(input)
    end
  end

  describe '#save' do
    it "Creates a file named 'save_game.yaml'" do
      expect(File).to receive(:open)
      game.save
    end
  end

  describe '#to_yaml' do
    it 'Dumps @chess_board and @white_player_turn' do
      game.instance_variable_set(:@chess_board, 'Chessboard')
      game.instance_variable_set(:@white_player_turn, 'White')
      output = "---\nchess_board: Chessboard\nwhite_player_turn: White\n"
      expect(game.to_yaml).to eq(output)
    end
  end

  describe '#from_yaml' do
    before do
      game.instance_variable_set(:@chess_board, nil)
      game.instance_variable_set(:@white_player_turn, nil)
    end

    it 'Restores @chess_board and @white_player_turn' do
      game.from_yaml('./spec/yaml_test.yaml')
      chess_board = game.instance_variable_get(:@chess_board)
      expect(chess_board).to eq('Chessboard')
    end

    it 'Restores @white_player_turn' do
      game.from_yaml('./spec/yaml_test.yaml')
      white_player_turn = game.instance_variable_get(:@white_player_turn)
      expect(white_player_turn).to eq('White')
    end
  end

  describe '#load_game' do
    before do
      allow(File).to receive(:exist?).and_return(true)
    end

    it "Does not call File.open or File.delete if input is 'N'" do
      input = 'N'
      allow(game).to receive(:gets).and_return(input)
      expect(File).to_not receive(:open)
      expect(File).to_not receive(:delete)
      game.load_game
    end

    it "Calls File.open and File.delete if input is 'Y'" do
      input = 'Y'
      allow(game).to receive(:gets).and_return(input)
      expect(File).to receive(:open)
      expect(File).to receive(:delete)
      game.load_game
    end
  end
end

# rubocop:enable Metrics/BlockLength
