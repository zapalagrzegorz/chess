# frozen_string_literal: true

require 'colorize'
require_relative 'cursor'
require_relative 'board'

# Render the square at the @cursor_pos display in a different color. Test that you can move your cursor around the board by creating and calling a method that loops through Display#render and Cursor#get_input (much as Player#make_move will function later!).

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], @board)
  end

  def render
    @board.rows.each do |row|
      # join rzutuje każdy element tablicy na string (to_s)
      puts " #{row.join(' ')}"
    end

    until @cursor.get_input
      system('clear')
      @board.rows.each_with_index do |row, row_idx|
        if @cursor.cursor_pos[0] == row_idx
          print_cursor(row)
        else
          # join rzutuje każdy element tablicy na string (to_s)
          puts row.join(' ').to_s
        end
      end
    end
  end

  private

  def print_cursor(row)
    cursor_col = @cursor.cursor_pos[1]
    begining = row[0...cursor_col].join(' ')
    ending = row[cursor_col + 1...row.length].join(' ')
    element = row[cursor_col].to_s.colorize(background: :red)

    puts "#{begining} #{element} #{ending}"
  end
end
