require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    node.children.each do |c|
      return c.prev_move_pos if c.winning_node?(mark)
    end
    node.children.each do |c|
      return c.prev_move_pos if !c.losing_node?(mark)
    end
    raise RuntimeError.new("No winner ")
    

  end
end

if $PROGRAM_NAME == __FILE__
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end