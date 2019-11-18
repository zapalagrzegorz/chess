require_relative "slideable"
require_relative "piece"

class Rook < Piece
  # :attr_reader :move_dirs
  #   attr_reader :DIRECTION

  include Slideable
  DIRECTION = [:STRAIGHT]

  def initialize(color, board, position)
    super(color, board, position)
  end

  def move_dirs
    DIRECTION
  end
end
