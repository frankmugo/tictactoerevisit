
require 'sinatra'

require_relative 'board.rb'

require_relative 'sequential.rb'

require_relative 'random.rb'

require_relative 'human.rb'

require_relative 'invincible.rb'



class TicTacToeApp < Sinatra::Base





enable :sessions



	get "/" do

		session[:board] = TTTBoard.new



		erb :a_get_players, :locals => {:board => session[:board].ttt_hash}

	end



	post "/gametype" do

		player1_type = params[:player1_type]

		player2_type = params[:player2_type]



		redirect "/gamesetup?player1_type=#{player1_type}&player2_type=#{player2_type}"

	end



	get "/gamesetup" do

		player1_type = params[:player1_type]

		player2_type = params[:player2_type]

		if player1_type == "human"

			session[:player1] = Human.new("X","Humanoid 1")

		elsif player1_type == "sequential"

			session[:player1] = Sequential.new("X")

		elsif player1_type == "random"

			session[:player1] = RandomPlayer.new("X")

		elsif player1_type == "invincible"

			session[:player1] = Invincible.new("X")

		end



		if player2_type == "human"

			session[:player2] = Human.new("O","Humanoid 2")

		elsif player2_type == "sequential"

			session[:player2] = Sequential.new("O")

		elsif player2_type == "random"

			session[:player2] = RandomPlayer.new("O")			

		elsif player2_type == "invincible"

			session[:player2] = Invincible.new("O")

		end



		session[:current_player] = session[:player1]



		erb :b_start_game, :locals => {:player1 => session[:player1], :player2 => session[:player2], :current_player => session[:current_player]}

	end



	post "/set_game" do

		if session[:player1].class != Human && session[:player2].class != Human

			redirect "/cpu_only"

		else

			redirect "/get_move"

		end



	end



	#  Computer vs computer logic currently separated from human interaction

	get "/cpu_only" do

		gametype_msg1 = "You chose to watch #{session[:player1].name} #{session[:player1].marker} vs #{session[:player2].name} #{session[:player2].marker}."

		gametype_msg2 = "Click the Make a Move button to proceed to next play"

		erb :cpu_only, :locals => {:gametype_msg1 => gametype_msg1, :gametype_msg2 => gametype_msg2, :board => session[:board].ttt_hash}

	end



	post "/cpu_only_move" do

		position = session[:current_player].get_move(session[:board])

		session[:board].update_position(position, session[:current_player].marker)

		if session[:board].winning_positions? || session[:board].tie?

			redirect "/display_result"

		end

		session[:current_player] = change_player(session[:current_player])

		gametype_msg1 = "Watching #{session[:player1].name} #{session[:player1].marker} vs #{session[:player2].name} #{session[:player2].marker}."

		gametype_msg2 = "Click the Make a Move button to proceed to next play"""



		erb :cpu_only, :locals => {:gametype_msg1 => gametype_msg1, :gametype_msg2 => gametype_msg2, :board => session[:board].ttt_hash}

	end



	def change_player(current_player)

		if session[:current_player] == session[:player1]

	       session[:current_player] = session[:player2]

	    else

	       session[:current_player] = session[:player1]   

	    end

	end

	#  End of segmented computer vs computer logic



	get "/get_move" do

		if session[:current_player].class == Human

			redirect "/request_human_move"

		elsif session[:current_player].class != Human

			position = session[:current_player].get_move(session[:board])

			redirect "/update_board?position=#{position}"

		end

	end



	get "/request_human_move" do

		gametype_msg = "#{session[:current_player].name} @ #{session[:current_player].marker} Select your play"

		game_err = ""



		erb :c_play_game, :locals => {:gametype_msg => gametype_msg, :game_err => game_err, :board => session[:board].ttt_hash}

	end 



	post "/get_human_move" do

		#puts "post for get_human_move #{params[:position]}"

		choice = params[:position].keys.join.to_sym



		if session[:board].ttt_hash[choice] == " "

			position = choice

			redirect "/update_board?position=#{position}"

		else

			gametype_msg = "#{session[:current_player].name} @ #{session[:current_player].marker}"

			game_err = "Selected space already taken.  Try again"

		

			erb :c_play_game, :locals => {:gametype_msg => gametype_msg, :game_err => game_err, :board => session[:board].ttt_hash}

		end



	end



	get "/update_board" do

		#puts "get for update_board #{params[:position]} current_player #{session[:current_player].marker}"

		position = params[:position].to_sym

		session[:board].update_position(position, session[:current_player].marker)

		

		if session[:board].winning_positions? || session[:board].tie?

			redirect "/display_result"

		else

			redirect "/change_player"

		end

	end



	get "/change_player" do

		if session[:current_player] == session[:player1]

	       session[:current_player] = session[:player2]

	    else

	       session[:current_player] = session[:player1]   

	    end

	    redirect "/get_move"

	end



	get "/display_result" do

		if session[:board].winning_positions?

	        gametype_msg = "\tHURRAY! #{session[:current_player].name} @ #{session[:current_player].marker} wins"

	    elsif session[:board].tie?

	 		gametype_msg = "\tIt was a tie!  Better luck next time."

	    else

	    	gametype_msg = "No idea how you got here!  Go play chess"

	    end

	    erb :display_result, :locals => {:gametype_msg => gametype_msg, :board => session[:board].ttt_hash}

	end



end
Contact GitHub API Training Shop Blog About 

© 2017 GitHub, Inc. Terms Privacy Security Status Help 