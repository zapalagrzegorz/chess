require "byebug"
require_relative "pieces/piece"
require_relative "pieces/null_piece"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/slideable"
require_relative "pieces/knight"
require_relative "pieces/pawn"
require_relative "pieces/king"

class Board
  #   COLORS = [:white, :black]
  WHITE_STARTING_ROWS = [6, 7].freeze
  BLACK_STARTING_ROWS = [0, 1].freeze
  PIECES_STARTING_ROWS = WHITE_STARTING_ROWS + BLACK_STARTING_ROWS

  FIGURE_PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].freeze

  attr_reader :rows

  # Write code for #initialize so we can setup the board
  # with instances of Piece in locations where a Queen/Rook/Knight/
  # etc. will start and nil where the NullPiece will start.
  def initialize
    @sentinel = Null_piece.instance

    @rows = Array.new(8) { Array.new(8, @sentinel) }

    @rows.each_index do |row_index|
      @rows[row_index].each_index do |col_index|
        fill_initial_piece(row_index, col_index)
      end
    end
  end

  # This should update the 2D grid and also the moved piece's position.

  # You'll want to raise an exception if:
  #  there is no piece at start_pos or
  # the piece cannot move to end_pos.
  #   est out Board#move_piece(start_pos, end_pos), does it raise an error when there is no piece at the start? Does it successfully update the Board?
  def move_piece(start_pos, end_pos)
    # start_row, start_col = start_pos
    # debugger
    raise NoFigureError if empty?(start_pos)

    raise OutOfBoardError unless valid_pos?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos].position = end_pos
    self[start_pos] = @sentinel

    true
  end

  def empty?(pos)
    self[pos].empty?
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def [](pos)
    # debugger
    row, col = pos
    @rows[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @rows[row][col] = val
  end

  # private
  def fill_initial_piece(row_index, col_index)
    if PIECES_STARTING_ROWS.include?(row_index)
      if WHITE_STARTING_ROWS.include?(row_index)
        add_piece_white(row_index, col_index)
        # return Piece.new(:white, self, [row_index, col_index])
      else
        add_piece_black(row_index, col_index)
      end
    else
      return nil
    end
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  private

  def add_piece_white(row_index, col_index)
    pos = [row_index, col_index]
    add_piece(Pawn.new(:white, self, pos), pos) if row_index == 6

    if row_index == 7
      add_piece(FIGURE_PIECES[col_index].new(:white, self, pos), pos)
    end
  end

  def add_piece_black(row_index, col_index)
    pos = [row_index, col_index]
    add_piece(Pawn.new(:black, self, pos), pos) if row_index == 1

    if row_index.zero?
      add_piece(FIGURE_PIECES[col_index].new(:black, self, pos), pos)
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
