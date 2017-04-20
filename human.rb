class Human



attr_accessor :marker, :name



	def initialize(marker, name)

		@marker = marker

		@name = name	

	end



	def get_move(board)

		position = 10

		until position != 10

			puts "Pick a position\n"

			puts "Board Selection Layout is\n

        	t1  |  t2  |  t3

        	----------------

        	m1  |  m2  |  m3

        	----------------

        	b1  |  b2  |  b3\n\n"



        	print " > "

			choice = gets.chomp.to_sym

	

			if board.avail_position?(choice)

				position = choice

				break

			end

			puts "Invalid space.  Try again"

		end

		position

	end

end



