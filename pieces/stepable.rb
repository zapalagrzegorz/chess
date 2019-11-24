require "byebug"

module Stepable
  def moves
    # logic for King and Knight
    # move_diffs
    row_idx, column_idx = self.position

    debugger
    possible_coords = move_diffs.map do |(dx, dy)|
      [row_idx + dx, column_idx + dy]
    end

    coords_on_board = possible_coords.select do |(row, col)|
      [row, col].all? do |coord|
        coord.between?(0, 7)
      end
    end

    moves = coords_on_board.reject do |pos|
      true if board[pos]&.color == self.color
    end

    moves
  end

  private

  def move_diffs
    # require implementation
    raise NotImplementedError
  end
end
