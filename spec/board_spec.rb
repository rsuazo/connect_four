require './lib/board'
require './lib/core_extensions'

RSpec.describe Board do
  describe '#initialize' do
    it 'initializes the board with a grid' do
      expect { Board.new(grid: 'grid') }.to_not raise_error
    end

    it 'sets the grid with 6 rows by default' do
      board = Board.new
      expect(board.grid.size).to eq(6)
    end

    it 'creates seven things in each row by default' do
      board = Board.new
      board.grid.each do |row|
        expect(row.size).to eq(7)
      end
    end
  end

  describe '#grid' do
    it 'returns the grid' do
      board = Board.new(grid: 'blah')
      expect(board.grid).to eq 'blah'
    end
  end

  describe '#get_cell' do
    it 'returns the cell based on the (x, y) coordinate ' do
      grid = [["", "", ""], ["", "", "something"], ["", "", ""]]
      board = Board.new(grid: grid)
      expect(board.get_cell(2, 1)).to eq 'something'
    end
  end

  describe '#set_cell' do
    it 'updates the value of the cell object at a (x, y) coordinate' do
      Cat = Struct.new(:value)
      grid = [[Cat.new("cool"), "", ""], ["", "", ""], ["", "", ""]]
      board = Board.new(grid: grid)
      board.set_cell(0, 0, "meow")
      expect(board.get_cell(0, 0).value).to eq "meow"
    end
  end

  TestCell = Struct.new(:value)
  let(:x_cell) { TestCell.new("X") }
  let(:y_cell) { TestCell.new("Y") }
  let(:empty) { TestCell.new }

  describe '#game_over' do
    it 'returns :winner if winner? is true' do
      board = Board.new
      allow(board).to receive(:winner?) { true }
      expect(board.game_over).to eq(:winner)
    end

    it "returns :draw if winner? is false and draw? is true" do
      board = Board.new
      allow(board).to receive(:winner?) { false }
      allow(board).to receive(:draw?) { true }
      expect(board.game_over).to eq :draw
    end
  
    it "returns false if winner? is false and draw? is false" do
      board = Board.new
      allow(board).to receive(:winner?) { false }
      allow(board).to receive(:draw?) { false }
      expect(board.game_over).to be_falsey
    end

    # it "returns :winner when row has objects with values that are all the same" do
    #   grid = [
    #     [x_cell, x_cell, x_cell],
    #     [y_cell, x_cell, y_cell],
    #     [y_cell, y_cell, empty]
    #   ]
    #   board = Board.new(grid: grid)
    #   expect(board.game_over).to eq :winner
    # end

    it 'returns :winner when row has 4 objects in a row with all the same value' do
      grid = [
        [empty, empty, x_cell, x_cell, x_cell, x_cell, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end

    it "returns :winner when colum has 4 objects in a row with the same value " do
      grid = [
        [empty, empty, empty, x_cell, empty, empty, empty],
        [empty, empty, empty, x_cell, empty, empty, empty],
        [empty, empty, empty, x_cell, empty, empty, empty],
        [empty, empty, empty, x_cell, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end
  
    it "returns :winner when diagonal has 4 objects in a row with the same value" do
      grid = [
        [empty, empty, empty, empty, empty, x_cell, empty],
        [empty, empty, empty, empty, x_cell, empty, empty],
        [empty, empty, empty, x_cell, empty, empty, empty],
        [empty, empty, x_cell, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :winner
    end
  
    it "returns :draw when all spaces on the board are taken" do
      grid = [
        [x_cell, y_cell, x_cell, y_cell, x_cell, y_cell, y_cell],
        [y_cell, y_cell, y_cell, x_cell, y_cell, x_cell, x_cell],
        [x_cell, x_cell, x_cell, y_cell, x_cell, y_cell, y_cell],
        [y_cell, y_cell, x_cell, y_cell, x_cell, y_cell, x_cell],
        [x_cell, x_cell, x_cell, y_cell, x_cell, x_cell, x_cell],
        [y_cell, y_cell, y_cell, x_cell, y_cell, y_cell, y_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to eq :draw
    end
  
    it "returns false when there is no winner or draw" do
      grid = [
        [empty, y_cell, empty, y_cell, empty, y_cell, y_cell],
        [y_cell, y_cell, y_cell, empty, y_cell, empty, empty],
        [empty, empty, x_cell, y_cell, x_cell, y_cell, y_cell],
        [y_cell, y_cell, x_cell, y_cell, x_cell, y_cell, x_cell],
        [x_cell, x_cell, x_cell, y_cell, x_cell, x_cell, x_cell],
        [y_cell, y_cell, y_cell, x_cell, y_cell, y_cell, y_cell]
      ]
      board = Board.new(grid: grid)
      expect(board.game_over).to be_falsey
    end
  end
end