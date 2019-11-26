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

  def valid_moves
    moves
    #  eleminuje ruchu, które mogą prowadzić do szacha
    #  moves.reject { |end_pos| move_into_check?(end_pos) }
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

  def move_into_check
  end
end
