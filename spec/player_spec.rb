require './lib/player'

RSpec.describe Player do
  describe '#initialize' do
    it 'raises an exception when initialized with {}' do
      expect { Player.new({}) }.to raise_error
    end

    it 'does not raise an error when initialized with a valid input hash' do
      input = { color: 'X', name: 'Robert' }
      expect { Player.new(input) }.to_not raise_error
    end
  end

  describe '#color' do
    it 'returns the color' do
      input = { color: 'X', name: 'Robert' }
      player = Player.new(input)
      expect(player.color).to eq 'X'
    end

    it 'returns the player name' do
      input = { color: 'X', name: 'Robert' }
      player = Player.new(input)
      expect(player.name).to eq 'Robert'
    end
  end
end