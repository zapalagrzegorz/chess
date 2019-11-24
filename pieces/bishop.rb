require_relative "piece"
require_relative "slideable"

class Bishop < Piece
  include Slideable
  DIRECTION = [:DIAGONAL].freeze

  def initialize(color, board, position)
    super(color, board, position)
  end

  def symbol
    "♝".colorize(color)
  end

  protected

  def move_dirs
    DIRECTION
  end
end
