require './lib/game'
require './lib/player'

RSpec.describe Game do

  let (:tiffany) { Player.new({color: "X", name: "tiffany"}) }
  let (:robert) { Player.new({color: "O", name: "robert"}) }
  let (:game) { Game.new([tiffany, robert]) }

  describe '#initialize' do
    it 'randomly select a current_player' do
      allow_any_instance_of(Array).to receive(:shuffle) { [robert, tiffany] }
      game = Game.new([tiffany, robert])
      expect(game.current_player).to eq robert
    end

    it "randomly selects an other player" do
      Array.any_instance.stub(:shuffle) { [robert, tiffany] }
      game = Game.new([tiffany, robert])
      expect(game.other_player).to eq tiffany
    end
  end

  describe "#switch_players" do
    it "will set @current_player to @other_player" do
      game = Game.new([tiffany, robert])
      other_player = game.other_player
      game.switch_players
      expect(game.current_player).to eq other_player
    end
  
    it "will set @other_player to @current_player" do
      game = Game.new([tiffany, robert])
      current_player = game.current_player
      game.switch_players
      expect(game.other_player).to eq current_player
    end
  end

  describe '#solicit_move' do
    it "asks the player to make a move" do
      game = Game.new([tiffany, robert])
      allow(game).to receive(:current_player) { tiffany }
      expected = "tiffany: Enter a number between 1 and 9 to make your move"
      expect(game.solicit_move).to eq expected
    end
  end

  TestCell = Struct.new(:value)
  let(:x_cell) { TestCell.new("X") }
  let(:y_cell) { TestCell.new("Y") }
  let(:empty) { TestCell.new }

  describe "#get_move" do
    # it "converts human_move of '0' to [0, 5]" do
    #   game = Game.new([tiffany, robert])
    #   expect(game.get_move("0")).to eq [0, 5]
    # end
  
    # it "converts human_move of '1' to [0, 0]" do
    #   game = Game.new([tiffany, robert])
    #   expect(game.get_move("7")).to eq [0, 2]
    # end

    it "converts human_move of '1' to [1, 5]" do
      grid = [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
      ]
      board = Board.new(grid: grid)
      game = Game.new([tiffany, robert], board)
      expect(game.get_move("1")).to eq [1, 5]
    end
  end

    describe "#game_over_message" do
      it "returns '{current player name} won!' if board shows a winner" do
        game = Game.new([tiffany, robert])
        allow(game).to receive(:current_player) { tiffany }
        allow(game.board).to receive(:game_over) { :winner }
        expect(game.game_over_message).to eq "tiffany won!"
      end

      it "returns 'The game ended in a tie' if board shows a draw" do
        game = Game.new([tiffany, robert])
        allow(game).to receive(:current_player) { tiffany }
        allow(game.board).to receive(:game_over) { :draw }
        expect(game.game_over_message).to eq "The game ended in a tie"
      end
    end

end