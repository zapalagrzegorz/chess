# frozen_string_literal: true

require "byebug"
# require_relative "rook"
# require_relative "null_piece"
require "colorize"

class Piece
  attr_reader :color, :board
  attr_accessor :position

  def initialize(color, board, position)
    #    board.add_piece(self, pos)
    @color = color
    @board = board
    @position = position
  end

  def to_s
    # print/ return symbol
    " #{symbol} "
  end

  def empty?
    false
  end

  # You will want a method on Piece that filters out the
  # moves of a Piece that would leave the player in check.
  def valid_moves
    valid_moves = moves.reject do |move|
      # debugger
      move_into_check?(move)
    end

    valid_moves
    # move_into_check(move)
  end

  def symbol
    # subclass implements this with unicode chess char
    raise NotImplementedError
  end

  def inspect
    { color: color,
      position: position,
      symbol: symbol }.inspect
  end

  private

  # To do this, you'll have to write a Board#dup method. Your #dup method should
  #  duplicate not only the Board, but the pieces on the Board.
  # Be aware: Ruby's #dup method does not call dup on the instance variables,
  # so you may need to write your own Board#dup method that will dup the
  # individual pieces as well.

  # A note on deep duping your board

  # As we saw when we recreated #dup using recursion, Ruby's native #dup method
  # does not make a deep copy. This means that nested arrays and any arrays
  # stored in instance variables will not be copied by the normal dup method:

  # Caution on duping pieces

  # If your piece holds a reference to the original board, you will need to
  # update this reference to the new duped board.
  # Failure to do so will cause your duped board to generate incorrect moves!
  def move_into_check?(end_pos)
    # Duplicate the Board and perform the move
    # debugger
    board_dup = deep_dup(@board)

    # Look to see if the player is in check after the move (Board#in_check?)
    board_dup.move_piece(position, end_pos)
    board_dup.in_check?(@color)
  end

  def deep_dup(board)
    # serialized_board =
    Marshal.load(Marshal.dump(board))
    # return [] if arr.length.zero?
    # duped_board = board.dup
    # # debug_index = 0
    # board.rows.each_with_index do |row, row_idx|
    #   # debug_index += 1
    #   # debugger
    #   duped_board.rows[row_idx] = row.dup
    # end
    # debugger
    # row.each_with_index do |tile, tile_idx|
    # unless tile.empty?
    # duped_board.rows[row_idx][tile_idx] = tile.dup
    # end
    # end
    # end
    # debug_index = 0
    # duped_board
  end
end
