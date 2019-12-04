# frozen_string_literal: true

# Abstrakcyjna klasa gracza
class Player
  attr_reader :name, :display

  def initialize(color, display)
    @color = color
    @display = display
  end

  def make_move()
    # subclass implements this
    raise NotImplementedError
  end
end
