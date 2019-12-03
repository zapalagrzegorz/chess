class InvalidMoveError < StandardError
  def message
    "Invalid move. Try again"
  end
end

class NoFigureError < StandardError
  def message
    "No figure found at this position. Please retry"
  end
end

class NoKingError < StandardError
  def message
    'Couldn\'t found King! piece'
  end
end

class OutOfBoardError < StandardError
  def message
    "Move has to finish on the board. Please retry."
  end
end
