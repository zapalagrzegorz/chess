require "byebug"
require "colorize"

require_relative "piece"

class Pawn < Piece
  def initialize(color, board, position)
    super(color, board, position)
  end

  # ?
  # def move_dirs
  # end

  def moves
    forward_steps + side_attacks
  end

  def symbol
    "♟".colorize(color)
  end

  def inspect
    { color: color,
      position: position,
      symbol: symbol }.inspect
  end

  private

  def at_start_row?
    return true if color == :white && position[0] == 6

    return true if color == :black && position[0] == 1

    false
  end

  def forward_dir
    color == :white ? -1 : 1
  end

  def forward_steps
    moves = []
    pawn_row, pawn_column = position

    forward = pawn_row + forward_dir
    # forward_tile = board[[forward, pawn_column]]
    pos = [forward, pawn_column]

    if board.empty?(pos)
      moves << pos
    else
      return []
    end

    if at_start_row?
      double_forward = pawn_row + forward_dir * 2
      # double_forward_tile = board[[double_forward, pawn_column]]
      pos = [double_forward, pawn_column]
      if board.empty?(pos)
        moves << pos
      end
    end

    moves
  end

  def side_attacks()
    pawn_row, pawn_column = position
    forward = pawn_row + forward_dir
    diagonal_right = pawn_column + 1
    diagonal_left = pawn_column - 1

    moves = [[forward, diagonal_right], [forward, diagonal_left]]

    # skosy

    moves.select do |pos|
      next unless board.valid_pos?(pos)

      diagonal_tile = board[pos]

      !board.empty?(pos) && diagonal_tile.color != color
    end
  end
end
