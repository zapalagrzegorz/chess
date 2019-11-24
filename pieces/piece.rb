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
    # print/ return symbol
  end

  def empty?
    # z zasady false
  end

  def valid_moves
    moves
    #  eleminuje ruchu, które mogą prowadzić do szacha
    #  moves.reject { |end_pos| move_into_check?(end_pos) }
  end

  def pos=(val)
    # valid_moves
    @position = val
  end

  def symbol
    # subclass implements this with unicode chess char
    # raise NotImplementedError
  end

  def inspect
    { color: color,
      position: position }.inspect
  end

  private

  def move_into_check
  end
end
