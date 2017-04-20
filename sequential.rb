require_relative 'board.rb'



class Sequential



	attr_accessor :marker, :board

	attr_reader :name



	def initialize(marker)

		@marker = marker

		@board = board

		@name = "Beginner Player"

	end



	def get_move(board)

		position = board.ttt_hash.key(" ") 	

	end



end