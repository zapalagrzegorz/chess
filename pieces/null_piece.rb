require "singleton"
require_relative "piece"

class Null_piece < Piece
  attr_reader :symbol
  include Singleton

  # nie przekazując parametrów konstruktorowi
  # nie chcę indywidualizować obiektu - dlatego,
  # że mam tu singleton - zawsze ma mieć tylko jedną instancję
  # o określonych właściwościach - nie można go zresztą wywołać przez new
  # a więc trzeba wcześniej mu podać właściwości

  def initialize
    @symbol = " "
    @color = :none
  end

  def moves
    []
  end

  def empty?
    true
  end
end
