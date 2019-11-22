# require_relative "rook"
# require_relative "null_piece"

class Piece
  attr_reader :color, :board, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    @position = position
  end

  def to_s
  end

  def empty?
  end

  def valid_moves
    # moves implements Slideable
    moves
  end

  def pos=(val)
    # valid_moves
    @position = val
  end

  def symbol
  end

  def inspect
    { color: color,
      position: position }.inspect
  end

  private

  def move_into_check
  end
end
