
require "byebug"

require_relative "stepable"
require_relative "piece"

class Knight < Piece
  include Stepable

  DELTAS = [
    [1, -2],  # bottom-left
    [-1, -2], # top-left
    [2, 1], # right-top
    [2, -1], # right-bottom
    [1, 2], # bottom-right
    [-1, 2], # bottom-left
    [-2, -1], # left-top
    [-2, 1],  # left-bottom
  ].freeze

  def initialize(color, board, position)
    super(color, board, position)
  end

  def symbol
    "♞".colorize(color)
  end

  protected

  def move_diffs
    DELTAS
  end
end
