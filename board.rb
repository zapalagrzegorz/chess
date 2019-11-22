require "byebug"
require_relative "pieces/piece"
require_relative "pieces/null_piece"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/slideable"

class Board
  #   COLORS = [:white, :black]
  WHITE_STARTING_ROWS = [0, 1]
  BLACK_STARTING_ROWS = [6, 7]
  PIECES_STARTING_ROWS = WHITE_STARTING_ROWS + BLACK_STARTING_ROWS

  attr_reader :rows

  # Write code for #initialize so we can setup the board
  # with instances of Piece in locations where a Queen/Rook/Knight/
  # etc. will start and nil where the NullPiece will start.
  def initialize
    @rows = Array.new(8) do |row_index|
      Array.new(8) do |col_index|
        fill_initial_piece(row_index, col_index)
      end
    end

    @sentinel = Null_piece.new
  end

  # This should update the 2D grid and also the moved piece's position.

  # You'll want to raise an exception if:
  #  there is no piece at start_pos or
  # the piece cannot move to end_pos.
  #   est out Board#move_piece(start_pos, end_pos), does it raise an error when there is no piece at the start? Does it successfully update the Board?
  def move_piece(start_pos, end_pos)
    # start_row, start_col = start_pos
    raise NoFigureError if empty?(start_pos)

    if end_pos.any? { |pos| !pos.between?(0, 7) }
      raise OutOfBoardError
    end

    self[end_pos] = self[start_pos]
    self[start_pos].pos = end_pos
    self[start_pos] = nil

    true
  end

  def empty?(pos)
    true if self[pos] == nil
  end

  # private

  def [](pos)
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  def fill_initial_piece(row_index, col_index)
    if PIECES_STARTING_ROWS.include?(row_index)
      if WHITE_STARTING_ROWS.include?(row_index)
        return Piece.new(:white, self, [row_index, col_index])
      else
        return Piece.new(:black, self, [row_index, col_index])
      end
    else
      return nil
    end
  end
end

class NoFigureError < StandardError
  def message
    "No figure found at this position. Please retry"
  end
end

class OutOfBoardError < StandardError
  def message
    "Move has to finish on the board. Please retry."
  end
end
