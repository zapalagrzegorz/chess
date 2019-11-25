require_relative "slideable"
require_relative "piece"

class Queen < Piece
  include Slideable
  DIRECTION = [:STRAIGHT, :DIAGONAL].freeze

  def initialize(color, board, position)
    super(color, board, position)
  end

  def symbol
    "♛".colorize(color)
  end

  protected

  def move_dirs
    DIRECTION
  end
end
