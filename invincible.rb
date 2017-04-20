require_relative 'board.rb'



class Invincible



	attr_accessor :marker

	attr_reader   :win_hash, :plays, :board, :name



	def initialize(marker)

		@marker = marker

		@win_hash = {r1: [:t1,:t2,:t3], r2: [:m1,:m2,:m3], r3: [:b1,:b2,:b3],

					c1: [:t1,:m1,:b1], c2: [:t2,:m2,:b2], c3: [:t3,:m3,:b3],

					d1: [:t1,:m2,:b3], d2: [:t3,:m2,:b1]}

		@plays = {diags: [[:t1,:b3],[:t3,:b1]], center: [:m2], edges: [:t2,:m1,:m3,:b2] }



		@board = board

		@name = "Hard Core Player"

	end



	def get_move(board)

		if check_win(board).class == Symbol

			position = check_win(board)

		elsif check_block(board).class == Symbol

			position = check_block(board)	

		elsif block_fork(board).class == Symbol

			position = block_fork(board)

		elsif create_fork(board).class == Symbol

		 	position = create_fork(board)

		elsif identify_open_play(board).class == Symbol

			position = identify_open_play(board)

		end

	end



	def block_fork(board)

		position = 10

		self.marker == "X" ? other_player = "O" : other_player = "X"

	 			

		plays[:diags].each do |matches|

		count = 0

			matches.each do |key_value|

				count += 1 if board.ttt_hash[key_value] == other_player

				position = identify_open_edge(board) if count == 2

			end

		end

		

		if position == 10

			played_hash = map_board(board)

			fork_array = []

			played_hash.each_pair do |key, valuearray|

				fork_array << valuearray if valuearray.count(other_player) == 1 && valuearray.grep(Symbol).length == 2	

			end



			flat_fork = fork_array.flatten

			flat_fork.each do |obj_match|

				position = obj_match if flat_fork.count(obj_match) > 1 && obj_match.class == Symbol

			end

			# move = flat_fork.find_all {|val| flat_fork.count(val) > 1 && val.class == Symbol}

			# position = move.uniq!.join.to_sym



		end

		position

	end



	def identify_open_edge(board)   

		position = 10

		plays[:edges].each do |key_value|

			position = key_value if board.ttt_hash[key_value] == " "

		end

		position

	end



	def create_fork(board)

		position = 10

	

		plays[:diags].each do |matches|

		count = 0

			matches.each do |key_value|

				count += 1 if board.ttt_hash[key_value] == self.marker

				position = identify_open_edge(board) if count == 2

			end

		end



		if position == 10

			played_hash = map_board(board)

			fork_array = []

			played_hash.each_pair do |key, valuearray|

				fork_array << valuearray if valuearray.count(self.marker) == 1 && valuearray.grep(Symbol).length == 2 

			end

			flat_fork = fork_array.flatten

			flat_fork.each do |obj_match|

				position = obj_match if flat_fork.count(obj_match) > 1 && obj_match.class == Symbol

			end

		end

		position	

	end



	def identify_open_play(board) 

		opencenter = 0; openedge = 0; opendiag = 0

		position = 10

		plays.each_pair do |key, valuearray|

			valuearray.each do |value|

				opencenter = value if board.ttt_hash[value] == " " && key == :center

				openedge = value if board.ttt_hash[value] == " " && key == :edges



				if key == :diags

					value.each do |find|

						opendiag = find.to_sym if board.ttt_hash[find] == " " && key == :diags

					end

				end

			end

		end



		if opencenter.class == Symbol

			position = opencenter

		elsif opendiag.class == Symbol

			position = opendiag

		elsif openedge.class == Symbol

			position = openedge

		end

		position

	end



	def map_board(board)

		played_hash = Hash.new



		win_hash.each_pair do |key, valuearray|

			played_hash[key] = Array.new()



			valuearray.each_with_index do |position, indx|

				if board.ttt_hash[position] == " "

					played_hash[key] << win_hash[key][indx]

				else

					played_hash[key] << board.ttt_hash[position]

				end

 			end

 		end

 		played_hash

	end	



	def check_win(board)

		played_hash = map_board(board)

		position = 10

		

		played_hash.each_pair do |key, valuearray|

			if valuearray.count(self.marker) == 2 && valuearray.one? {|obj| obj.class == Symbol}

				result = valuearray.grep(Symbol)

				position = result.join.to_sym

			end

		end

		position

	end



	def check_block(board)

		played_hash = map_board(board)

		position = 10

		self.marker == "X" ? other_player = "O" : other_player = "X"



		played_hash.each_pair do |key, valuearray|

			if valuearray.count(other_player) == 2 && valuearray.one? {|obj| obj.class == Symbol}

				result = valuearray.grep(Symbol)

				position = result.join.to_sym

				break

			end

		end

		position

	end



end


