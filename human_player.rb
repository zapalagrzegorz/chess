# frozent
# Klasa gracza
class HumanPlayer < Player
  def initialize(color, display)
    super(color, display)
  end

  #   You should write a HumanPlayer class with one method (#make_move). This method should call Cursor#get_input and appropriately handle the different responses (a cursor position or nil). In that case, Game#play method just continuously calls #make_move.
  def make_move(_board)
    display.render
  end
end
