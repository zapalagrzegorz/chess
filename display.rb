# frozen_string_literal: true
require "byebug"

require "colorize"
require_relative "cursor"
require_relative "board"

# Render the square at the @cursor_pos display in a different color. Test that you can move your cursor around the board by creating and calling a method that loops through Display#render and Cursor#get_input (much as Player#make_move will function later!).

class Display
  attr_reader :board, :cursor

  def initialize(board, debug = true)
    @board = board
    @cursor = Cursor.new([0, 0], @board)
    @debug = debug
  end

  def render
    selected_tiles = []
    until selected_tiles.length == 2
      system("clear")

      valid_moves =
        if selected_tiles.any?
          @board[selected_tiles[0]].valid_moves
        else
          @board[@cursor.cursor_pos].valid_moves
        end

      print_board_options = {
        cur_row: @cursor.cursor_pos[0],
        cur_idx: @cursor.cursor_pos[1],
        valid_moves: valid_moves,
      }

      puts printable_board(print_board_options)

      if @debug
        p @board[@cursor.cursor_pos].valid_moves
        puts "Is white in check? #{@board.in_check?(:white)}"

        puts "Is black in check? #{@board.in_check?(:black)}"
      end

      move = @cursor.get_input
      if move
        if selected_tiles.empty? && @board[move].valid_moves.any?
          selected_tiles << move
        else
          selected_tiles << move
        end
      end
    end

    selected_tiles
  end

  def render_board
    valid_moves =
      if selected_tiles.any?
        @board[selected_tiles[0]].valid_moves
      else
        @board[@cursor.cursor_pos].valid_moves
      end

    print_board_options = {
      cur_row: @cursor.cursor_pos[0],
      cur_idx: @cursor.cursor_pos[1],
      valid_moves: valid_moves,
    }

    puts printable_board(print_board_options)
  end

  private

  # parametry są destrukturyzowane od razu z hasha przekazywanego
  # jako argument
  def printable_board(cur_row:, cur_idx:, valid_moves:)
    printable_board = "   #{(0..7).to_a.join("  
6  ♟  ♟  ☐  ♟  ♟  ☐  ♟  ♟ ")}"

    @board.rows.each_with_index do |row, row_idx|
      printable_board += "\n"
      printable_board += "#{row_idx} "

      row.each_index do |tile_idx|
        if row_idx == cur_row && tile_idx == cur_idx
          printable_board += row[tile_idx].to_s.colorize(background: :yellow)
        elsif valid_moves.any? { |move| move[0] == row_idx && move[1] == tile_idx }
          printable_board += row[tile_idx].to_s.colorize(background: :blue)
        else
          # debugger
          printable_board += row[tile_idx].to_s
        end
      end
    end

    printable_board
  end

  def print_cursor(row)
    cursor_col = @cursor.cursor_pos[1]
    begining = row[0...cursor_col].join(" ")
    ending = row[cursor_col + 1...row.length].join(" ")
    element = row[cursor_col].to_s.colorize(background: :red)

    puts "#{begining} #{element} #{ending}"
  end
end
