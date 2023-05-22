
require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    @board.open_positions.each do |pos|
      new_board = @board.dup
      new_board[pos]= @next_mover_mark
      node = TicTacToeNode.new(new_board, new_board.next_mark, pos)
      @children << node
    end
    return @children
  end
end