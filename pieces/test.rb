# The NullPiece class should include the singleton module.
# It will not need a reference to the Board - in fact its initialize method
# should take no arguments. Make sure you have a way to read its color
# and symbol.
require "singleton"
require_relative "piece"

class Test_piece < Piece
  def initialize
    # super
    @internal = "internal"
    # @color = :none
  end

  def move
  end

  def symbol
  end
end
