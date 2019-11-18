# You should make modules for Slideable and Stepable. The Slideable module can implement #moves, but it needs to know what directions a piece can move in (diagonal, horizontally/vertically, both). Classes that include the module Slideable (Bishop/Rook/Queen) will need to implement a method #move_dirs, which #moves will use.

# Your Piece will need to (1) track its position and (2) hold a reference to the Board. Classes that include Slideable in particular need the Board so they know to stop sliding when blocked by another piece. Don't allow a piece to move into a square already occupied by the same color piece, or to move a sliding piece past a piece that blocks it.
module Slideable
  def moves
    moves = []

    if self.move_dirs.include?(:STRAIGHT)
      row_idx, column_idx = self.position

      debugger
      moves = check_vertical(moves, row_idx, column_idx)

      moves = check_horizontal(moves, row_idx, column_idx)
    end

    moves
  end

  private

  def check_vertical(moves, row_idx, column_idx)
    moves = check_top(moves, row_idx + 1, column_idx)
    moves = check_bottom(moves, row_idx - 1, column_idx)

    moves
  end

  def check_top(moves, row_idx, column_idx)
    while board[[row_idx, column_idx]] == nil && row_idx <= 7
      moves << [row_idx, column_idx]
      row_idx += 1
    end

    if board[[row_idx, column_idx]]&.color != self.color
      moves << [row_idx, column_idx]
    end

    moves
  end

  def check_bottom(moves, row_idx, column_idx)
    while board[[row_idx, column_idx]] == nil && row_idx >= 0
      moves << [row_idx, column_idx]
      row_idx -= 1
    end

    if row_idx >= 0 && board[[row_idx, column_idx]].color != self.color
      moves << [row_idx, column_idx]
    end

    moves
  end

  def check_horizontal(moves, row_idx, column_idx)
    moves = check_left(moves, row_idx, column_idx - 1)
    moves = check_right(moves, row_idx, column_idx + 1)

    moves
  end

  def check_right(moves, row_idx, column_idx)
    while board[[row_idx, column_idx]] == nil && column_idx <= 7
      moves << [row_idx, column_idx]
      column_idx += 1
    end

    if column_idx <= 7 && board[[row_idx, column_idx]]&.color != self.color
      moves << [row_idx, column_idx]
    end

    moves
  end

  def check_left(moves, row_idx, column_idx)
    while board[[row_idx, column_idx]] == nil && column_idx >= 0
      moves << [row_idx, column_idx]
      column_idx -= 1
    end

    # safe operator po prostu zwraca nil, nie rzuca błędem
    if column_idx >= 0 && board[[row_idx, column_idx]]&.color != self.color
      moves << [row_idx, column_idx]
    end

    moves
  end
end
