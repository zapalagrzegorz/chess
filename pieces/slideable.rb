# frozen_string_literal: true

module Slideable
  def moves
    moves = []

    row_idx, column_idx = self.position

    if self.move_dirs.include?(:STRAIGHT)
      # debugger
      moves = check_vertical(moves, row_idx, column_idx)

      moves = check_horizontal(moves, row_idx, column_idx)
    end

    if self.move_dirs.include?(:DIAGONAL)
      # debugger
      moves = check_diagonal_top(moves, row_idx, column_idx)

      moves = check_diagonal_bottom(moves, row_idx, column_idx)
    end

    moves
  end

  private

  def check_vertical(moves, row_idx, column_idx)
    moves = check_top(moves, row_idx - 1, column_idx)
    moves = check_bottom(moves, row_idx + 1, column_idx)

    moves
  end

  def check_top(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]

    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      row_idx -= 1
      pos = [row_idx, column_idx]
    end

    if board.valid_pos?(pos) && self.board[pos]&.color != self.color
      moves << pos
    end

    moves
  end

  def check_bottom(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      row_idx += 1
      pos = [row_idx, column_idx]
    end

    if board.valid_pos?(pos) && self.board[pos].color != self.color
      moves << pos
    end

    moves
  end

  def check_horizontal(moves, row_idx, column_idx)
    moves = check_left(moves, row_idx, column_idx - 1)
    moves = check_right(moves, row_idx, column_idx + 1)

    moves
  end

  def check_right(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      column_idx += 1
      pos = [row_idx, column_idx]
    end

    if board.valid_pos?(pos) && board[pos]&.color != self.color
      moves << pos
    end

    moves
  end

  def check_left(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      column_idx -= 1
      pos = [row_idx, column_idx]
    end

    # safe operator po prostu zwraca nil, nie rzuca błędem
    if board.valid_pos?(pos) && board[pos]&.color != self.color
      moves << pos
    end

    moves
  end

  def check_diagonal_top(moves, row_idx, column_idx)
    moves = check_diagonal_top_right(moves, row_idx - 1, column_idx + 1)
    moves = check_diagonal_top_left(moves, row_idx - 1, column_idx - 1)

    moves
  end

  def check_diagonal_bottom(moves, row_idx, column_idx)
    moves = check_diagonal_bottom_right(moves, row_idx + 1, column_idx + 1)
    moves = check_diagonal_bottom_left(moves, row_idx + 1, column_idx - 1)

    moves
  end

  def check_diagonal_top_right(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      row_idx -= 1
      column_idx += 1
      pos = [row_idx, column_idx]
    end

    if board.valid_pos?(pos) && board[[row_idx, column_idx]]&.color != self.color
      moves << [row_idx, column_idx]
    end

    moves
  end

  def check_diagonal_top_left(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      row_idx -= 1
      column_idx -= 1
      pos = [row_idx, column_idx]
    end

    if row_idx >= 0 && column_idx >= 0 && board[pos]&.color != self.color
      moves << pos
    end

    moves
  end

  def check_diagonal_bottom_right(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      row_idx += 1
      column_idx += 1
      pos = [row_idx, column_idx]
    end

    if board.valid_pos?(pos) && board[pos]&.color != self.color
      moves << pos
    end

    moves
  end

  def check_diagonal_bottom_left(moves, row_idx, column_idx)
    pos = [row_idx, column_idx]
    while board.valid_pos?(pos) && board.empty?(pos)
      moves << pos
      row_idx += 1
      column_idx -= 1
      pos = [row_idx, column_idx]
    end

    if board.valid_pos?(pos) && self.board[pos]&.color != self.color
      moves << pos
    end

    moves
  end

  def move_dirs
    raise NotImplementedError
  end
end
