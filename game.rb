`# frozen_string_literal: true`

require "byebug"
require_relative "board.rb"
require_relative "display.rb"
require_relative "human_player.rb"

# Wrapping class
class Game
  attr_reader :board, :display, :players

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      player1: HumanPlayer.new(:white, @display),
      player2: HumanPlayer.new(:black, @display),
    }
    @current_player = @players[:player1]
  end

  def play
    loop do
      begin
        start_pos, end_pos = *@current_player.make_move
        @board.move_piece(start_pos, end_pos, @current_player.color)
      rescue InvalidMoveError => e
        puts e.message
        sleep(1.5)
        retry
      end
      swap_turn!

      break if @board.checkmate?(@current_player.color)
    end

    swap_turn!
    @display.render_board
    puts "\n#{@current_player.color.to_s.capitalize} has win. "
  end

  #   private
  def notify_players
  end

  def swap_turn!
    @current_player = @current_player == @players[:player1] ? @players[:player2] : @players[:player1]
  end
end

if $PROGRAM_NAME == __FILE__
  Game.new.play
end
