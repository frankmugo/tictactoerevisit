class TTTBoard



	attr_accessor :ttt_hash

	

	def initialize()

		@ttt_hash = {t1: " ", t2: " ", t3: " ", m1: " ", m2: " ", m3: " ", b1: " ", b2: " ", b3: " "}

	end



	def update_position(position, marker)

		ttt_hash[position] = marker

	end



	def avail_position?(position)

		ttt_hash[position] == " "

	end



	def board_full?()

		ttt_hash.has_value?(" ") == false

	end



	def tie?()

		board_full? && winning_positions? == false

	end



	def winning_positions?()

		win_hash = {r1: [:t1,:t2,:t3], r2: [:m1,:m2,:m3], r3: [:b1,:b2,:b3], c1: [:t1,:m1,:b1], c2: [:t2,:m2,:b2], c3: [:t3,:m3,:b3], d1: [:t1,:m2,:b3], d2: [:t3,:m2,:b1]}

		win = false

		win_hash.each_pair do |key, valuearray|

			x_count = 0; o_count = 0

			valuearray.each do |countit|

				x_count += 1 if ttt_hash[countit] == "X"

				o_count += 1 if ttt_hash[countit] == "O"

				

				win = true if x_count == 3 || o_count == 3

			end

			#puts "\tkey #{key} X #{x_count}   O #{o_count}"

		end

		win

	end



end

