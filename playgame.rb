require_relative "console.rb"



#puts "\e[H\e[2J"   #clear console

puts "How about a nice game of Tic-Tac-Toe?\n\n"



puts "What type of game shall we play?

	1 = Player vs Player

	2 = Player vs Sequential

	3 = Player vs Random

	4 = Sequential vs Sequential

	5 = Sequential vs Random

	6 = Random vs Random

	7 = Player vs Invincible

	8 = Sequential vs Invincible

	9 = Random vs Invincible

	10 = Invincible vs Invincible"

print " > "



type = gets.chomp.to_i



case type



	when 1

		puts "What is Player 1's name?"

		player1_name = gets.chomp

		puts "Would you like to be X or O?"

		player1_marker = gets.chomp.upcase

		puts "What is Player 2's name?"

		player2_name = gets.chomp

		if player1_marker == "X"

			player2_marker = "O"

		elsif player1_marker == "O"

			player2_marker = "X"

		end

		player1 = Human.new(player1_marker, player1_name)

		player2 = Human.new(player2_marker, player2_name)

		puts player2.player2_name

		game = Console.new(player1, player2, current_player)

		puts game.current_player 



	when 2

		puts "What is Player 1's name?"

		player1_name = gets.chomp

		puts "Would you like to be X or O?"

		player1_marker = gets.chomp.upcase

		if player1_marker == "X"

			player2_marker = "O"

		else

			player2_marker = "X"

		end

		player1 = Human.new(player1_marker, player1_name)

		player2 = Sequential.new(player2_marker)

		game = Console.new(player1,player2,player2)



	when 3

		puts "What is Player 1's name?"

		player1_name = gets.chomp

		puts "Would you like to be X or O?"

		player1_marker = gets.chomp.upcase

			if player1_marker == "X"

				player2_marker = "O"

			else

				player2_marker = "X"

			end

			player1 = Human.new(player1_marker, player1_name)

			player2 = RandomPlayer.new(player2_marker)

			game = Console.new(player1,player2,player2)



	when 4

		player1 = Sequential.new("X")

		player2 = Sequential.new("O")

		game = Console.new(player1,player2,player2)



	when 5

		player1 = Sequential.new("X")

		player2 = RandomPlayer.new("O")

		game = Console.new(player1,player2,player2)



	when 6

		player1 = RandomPlayer.new("X")

		player2 = RandomPlayer.new("O")

		game = Console.new(player1,player2,player2)



	when 7

		puts "What is Player 1's name?"

		player1_name = gets.chomp

		puts "Would you like to be X or O?"

		player1_marker = gets.chomp.upcase

			if player1_marker == "X"

				player2_marker = "O"

			else

				player2_marker = "X"

			end

		player1 = Human.new(player1_marker,player1_name)

		player2 = Invincible.new(player2_marker)

		game = Console.new(player1,player2,player2)



	when 8

		player1 = Sequential.new("X")

		player2 = Invincible.new("O")

		game = Console.new(player1,player2,player2)



	when 9

		player1 = RandomPlayer.new("X")

		player2 = Invincible.new("O")

		game = Console.new(player1,player2,player2)



	when 10

		player1 = Invincible.new("X")

		player2 = Invincible.new("O")

		game = Console.new(player1,player2,player2)

end



	game.display_board

	until game.game_over?

		game.change_player(@current_player)

		puts "\t\tIt's #{game.current_player.name} #{game.current_player.marker}'s turn."

		sleep 0.5

		position = game.get_move

		game.update_board(position)

	#	puts "\e[H\e[2J"   #clear console

		game.display_board

		

	end

	game.display_game_status