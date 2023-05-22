
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
    
    
    return true if winner && winner != evaluator 
    return false if winner == evaluator || (winner == nil && board.over?)
    if next_mover_mark != evaluator
      return self.children.any? { |c| c.losing_node?(evaluator) }
    else
      return self.children.all? { |c| c.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
  end

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

