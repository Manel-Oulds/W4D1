
require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
  end

  def inspect
    "nmm: #{next_mover_mark}, pmp: #{prev_move_pos}"
  end

  def losing_node?(evaluator)
    winner = board.winner
    
    # p "is board over: #{board.over?}"
    
    return true if winner && winner != evaluator 
    return false if winner == evaluator
    return false if winner == nil && board.over?

    # p "evaluator: #{evaluator}"
    # p "next_mover_mark: #{next_mover_mark}"
    # p "children: #{children}"

    if next_mover_mark != evaluator
      # p 'first condition'
      return self.children.all? { |c| c.losing_node?(evaluator) }
    else
      # p 'second condition'
      return self.children.any? { |c| c.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @board.open_positions.each do |pos|
      new_board = @board.dup
      new_board[pos]= @next_mover_mark
      
      next_mark = next_mover_mark == :x ? :o : :x

      node = TicTacToeNode.new(new_board, next_mark, pos)
      @children << node
    end
    return @children
  end
end

# node = TicTacToeNode.new(Board.new, :x)
# node.board[[0, 0]] = :o
# node.board[[2, 2]] = :o
# node.board[[0, 2]] = :o
# p node.losing_node?(:x)

# node = TicTacToeNode.new(Board.new, :o)
# node.board[[0, 0]] = :x
# node.board[[0, 1]] = :x
# node.board[[0, 2]] = :o
# node.board[[1, 1]] = :o
# node.board[[1, 0]] = :x
# p node.losing_node?(:x)
