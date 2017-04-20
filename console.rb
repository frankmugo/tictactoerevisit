require_relative 'board.rb'

require_relative 'sequential.rb'

require_relative 'random.rb'

require_relative 'human.rb'

require_relative 'invincible.rb'



class Console



	attr_accessor :board, :player1, :player2, :current_player



	def initialize(player1, player2, current_player)

		@board = TTTBoard.new

		@player1 = player1

		@player2 = player2

		@current_player = current_player

	end



    def display_intro

        puts "\tHow about a nice game of Tic-Tac-Toe\n"

    end



	def display_board

        puts "Game Board\n

		#{@board.ttt_hash[:t1]}  |  #{@board.ttt_hash[:t2]}  |  #{@board.ttt_hash[:t3]}\n

		---------------

		#{@board.ttt_hash[:m1]}  |  #{@board.ttt_hash[:m2]}  |  #{@board.ttt_hash[:m3]}\n

		---------------

		#{@board.ttt_hash[:b1]}  |  #{@board.ttt_hash[:b2]}  |  #{@board.ttt_hash[:b3]}\n\n\n"

    end



    def change_player(current_player)

        if @current_player == player1   

            @current_player = player2

        else

            @current_player = player1

        end

        @current_player

    end



    def get_move

    	current_player.get_move(board)

    end



    def update_board(position)

        board.update_position(position, current_player.marker)

    end



    def game_over?

    	board.winning_positions? || board.tie?

    end



    def display_game_status

        if board.winning_positions?

            puts "\tHURRAY! #{current_player.name} @ #{current_player.marker} wins"

        elsif board.tie?

            puts "\tIt was a tie!"

        else

            "No idea how you got here!  Go play chess"

        end

    end



end