require_relative "../lib/game"
require_relative '../lib/player'
require_relative '../lib/core_extensions'


 
puts "Welcome to tic tac toe"
robert = Player.new({color: "X", name: "robert"})
tiffany = Player.new({color: "O", name: "tiffany"})
players = [robert, tiffany]
game = Game.new(players)
game.play