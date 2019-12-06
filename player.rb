# frozen_string_literal: true

# Abstrakcyjna klasa gracza
class Player
  attr_reader :color, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move()
    # subclass implements this
    raise NotImplementedError
  end

  def inspect
    { color: color }.inspect
  end
end
