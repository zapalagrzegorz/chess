# frozen_string_literal: true

require "byebug"
# require_relative "rook"
# require_relative "null_piece"
require "colorize"
require_relative "../deep_dup"

# Abstract class of Piece
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
    # debugger if end_pos == [7, 4]

    board_dup = @board.deep_dup

    board_dup.move_piece!(position, end_pos)

    board_dup.in_check?(@color)
  end
end
