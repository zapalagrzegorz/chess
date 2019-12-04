# Write a Game class that constructs a Board object, then alternates between players (assume two human players for now) prompting them to move. The Game should handle exceptions from Board#move_piece and report them.

# You should write a HumanPlayer class with one method (#make_move). This method should call Cursor#get_input and appropriately handle the different responses (a cursor position or nil). In that case, Game#play method just continuously calls #make_move.

class Game
  def initialize()
    @board = Board.new
    @display = Display.new
    @players = {
      player1: Player.new,
      player2: Player.new,
    }
    @current_player = players[:player1]
  end

  def play
    unless @board.checkmate?(@current_player.color)
      start_pos, end_pos = *@current_player.make_move
      @board.move_piece(start_pos, end_pos)
    end
  end

  #   private
  def notify_players
  end

  def swap_turn!
    @current_player = @current_player == :player1 ? players[:player2] : players[:player1]
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
