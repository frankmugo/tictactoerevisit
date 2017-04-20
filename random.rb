require_relative 'board.rb'

require_relative 'console.rb'



class RandomPlayer



	attr_accessor :marker

	attr_reader :name



	def initialize(marker)

		@marker = marker

		@name = "Casual Player"

	end



	def get_move(board)

		position = 10

		until position != 10

			key = board.ttt_hash.keys.sample

			position = key if board.ttt_hash[key] == " "

		end

		position

	end

end