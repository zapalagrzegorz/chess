# frozen_string_literal: true

require_relative "player.rb"

# Klasa gracza
class HumanPlayer < Player
  def initialize(color, display)
    super(color, display)
  end

  def make_move
    display.render
  end
end
