
require "byebug"

require_relative "stepable"
require_relative "piece"

class King < Piece
  include Stepable

  DELTAS = [
    [-1, 0], # top
    [-1, 1], # top-right
    [0, 1], # right
    [1, 1], # bottom-right
    [1, 0], # bottom
    [1, -1], # bottom-left
    [0, -1], # left
    [-1, -1], # top-left
  ].freeze

  def initialize(color, board, position)
    super(color, board, position)
  end

  def symbol
    "♔".colorize(color)
  end

  protected

  def move_diffs
    DELTAS
  end
end
