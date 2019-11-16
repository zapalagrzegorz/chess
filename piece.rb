class Piece
  attr_reader :color, :board, :position

  def initialize(color, board, position)
    @color = color
    @board = board
    # position: array
    @position = position
  end

  def to_s
  end

  def empty?
  end

  def valid_moves
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
