# frozen_string_literal: true

require "byebug"
require_relative "exceptions"
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

  def move_piece(start_pos, end_pos)
    raise NoFigureError if empty?(start_pos)

    raise OutOfBoardError unless valid_pos?(end_pos)

    # debugger
    raise InvalidMoveError unless self[start_pos].valid_moves.include?(end_pos)

    self[end_pos] = self[start_pos]
    self[start_pos].position = end_pos
    self[start_pos] = @sentinel

    true
  end

  def move_piece!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos].position = end_pos
    self[start_pos] = @sentinel
  end

  def empty?(pos)
    self[pos].empty?
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def [](pos)
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
    end
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def in_check?(color)
    king_pos = find_king(color)

    opposing_color = color == :white ? :black : :white
    opposing_pieces = find_color_pieces(opposing_color)

    king_threathened?(opposing_pieces, king_pos)
  end

  def checkmate?(color)
    player_pieces = find_color_pieces(color)
    player_moves = player_pieces.reduce(0) { |memo, piece|
      memo + piece.valid_moves.length
    }

    return true if in_check?(color) && player_moves.zero?
    # end
  end

  def test_check_mate
    move_piece([6, 5], [5, 5])
    move_piece([1, 4], [3, 4])
    move_piece([6, 6], [4, 6])
    move_piece([0, 3], [4, 7])
    in_check?(:white)
  end

  def deep_dup
    Marshal.load(Marshal.dump(self))
    # TODO check it again

    # return [] if arr.length.zero?
    # duped_board = board.dup
    # # debug_index = 0
    # board.rows.each_with_index do |row, row_idx|
    #   # debugger
    #   duped_board.rows[row_idx] = row.dup
    # end
    # debugger
    # row.each_with_index do |tile, tile_idx|
    # unless tile.empty?
    # duped_board.rows[row_idx][tile_idx] = tile.dup
    # end
    # end
    # end
    # duped_board
  end

  private

  def find_king(color)
    rows.each do |row|
      row.each do |tile|
        return tile.position if tile.instance_of?(King) && tile.color == color
      end
    end

    raise NoKingError
  end

  def find_opposing_pieces(color)
    opposing_pieces = []
    rows.each do |row|
      row.each do |tile|
        opposing_pieces << tile if tile.color == color
      end
    end

    raise NoFigureError if opposing_pieces.empty?

    opposing_pieces
  end

  def find_color_pieces(color)
    pieces = []
    rows.each do |row|
      row.each do |tile|
        pieces << tile if tile.color == color
      end
    end

    raise NoFigureError if pieces.empty?

    pieces
  end

  def king_threathened?(pieces, king_pos)
    pieces.any? do |piece|
      return true if piece.moves.include?(king_pos)
    end
  end

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
