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

  # filters out moves of piece that would leave player in check.
  def valid_moves
    valid_moves = moves.reject do |move|
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
    board_dup = @board.deep_dup

    # Look to see if the player is in check after the move (Board#in_check?)
    board_dup.move_piece!(position, end_pos)
    board_dup.in_check?(@color)
  end
end
