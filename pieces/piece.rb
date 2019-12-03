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

  def move_into_check?(end_pos)
    # Duplicate the Board and perform the move
    # debugger
    board_dup = deep_dup(@board)

    # Look to see if the player is in check after the move (Board#in_check?)
    board_dup.move_piece(position, end_pos)
    board_dup.in_check?(@color)
  end

  def deep_dup(board)
    Marshal.load(Marshal.dump(board))
    # TODO check it again

    # return [] if arr.length.zero?
    # duped_board = board.dup
    # # debug_index = 0
    # board.rows.each_with_index do |row, row_idx|
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
    # duped_board
  end
end
