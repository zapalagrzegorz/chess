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
    @board.rows.each do |row|
      # join rzutuje każdy element tablicy na string (to_s)
      puts " #{row.join(" ")}"
    end

    until @cursor.get_input
      system("clear")
      valid_moves = @board[@cursor.cursor_pos].valid_moves
      printable_board = ""
      cur_row = @cursor.cursor_pos[0]
      cur_idx = @cursor.cursor_pos[1]
      @board.rows.each_with_index do |row, row_idx|
        printable_board += "\n"

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
      puts printable_board
      # debugger

      if @debug
        # debugger
        p @board[@cursor.cursor_pos].valid_moves
        # debugger
        puts "Is white in check? #{@board.in_check?(:white)}"

        puts "Is black in check? #{@board.in_check?(:black)}"
      end
    end
  end

  private

  def print_cursor(row)
    cursor_col = @cursor.cursor_pos[1]
    begining = row[0...cursor_col].join(" ")
    ending = row[cursor_col + 1...row.length].join(" ")
    element = row[cursor_col].to_s.colorize(background: :red)

    puts "#{begining} #{element} #{ending}"
  end
end
