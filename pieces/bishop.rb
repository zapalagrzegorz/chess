require_relative "slideable"
require_relative "piece"

class Bishop < Piece
  include Slideable
  DIRECTION = [:DIAGONAL].freeze

  def initialize(color, board, position)
    super(color, board, position)
  end

  def move_dirs
    DIRECTION
  end
end
