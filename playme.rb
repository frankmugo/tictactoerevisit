require_relative "console.rb"



player1 = Sequential.new("X")

player2 = Invincible.new("O")

game = Console.new(player1,player2,player2)



round_count = 0

game.display_intro

game.display_board	

until game.game_over?

	round_count += 1

	game.change_player(@current_player)

    puts "\t\tIt's #{game.current_player.name} #{game.current_player.marker}'s turn."  #put's causes test failure

#	sleep 0.5
get_move

	position = game.
	game.update_board(position)

#	puts "\e[H\e[2J"   #clear console

	game.display_board

end

game.display_game_status



puts "Round count = #{round_count}"
