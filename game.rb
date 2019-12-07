`# frozen_string_literal: true`

require "byebug"
require_relative "board.rb"
require_relative "display.rb"
require_relative "human_player.rb"

# Wrapping class
class Game
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

  def move_player
    user_input = nil
    until user_input
      puts "#{current_player}, please give new start and end position like 0,0 2,0"
      user_input = STDIN.gets.chomp
      user_input = parse_input(user_input)
      puts
    end

    @board.move_piece[user_input[start_pos], user_input[end_pos]]
  end

  def parse_input(user_input)
    return nil unless user_input[2] =~ /^[0-7],[0-7]\s[0-7],[0-7]/

    start_pos = user_input[0..2].split(",").map { |pos| Integer(pos) }
    end_pos = user_input[4..6].split(",").map { |pos| Integer(pos) }

    return {
             "start_pos" => start_pos,
             "end_pos" => end_pos,
           }
  end
end
