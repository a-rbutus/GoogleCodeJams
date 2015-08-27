class Solvy 

	#attr_accessor :testCases, :numTestCases

	def initialize
		@test_cases = Array.new
		@num_test_cases = 0
	end

	def load_input
		File.foreach("ovation-large.in") do |line|
  		 	if @num_test_cases == 0
  		 		@num_test_cases = line.to_i
  		 	else 
  		 		@test_cases.push(Audience.new(line))
  		 	end 
	  	end
	end

  	def output_solution
		solution = ""
  		@test_cases.each_with_index do |item, index|
  			solution << "Case ##{index + 1}: #{item.solve}\n"
  		end

		File.open("ovationOutput.txt", 'w') { |file| file.write(solution) }
  	end

	class Audience

		def initialize(line)
			split_line = line.split(' ')
			#@max_shyness = split_line[0].to_i
			@people_per_shyness_level = split_line[1].to_s.chars.map(&:to_i)
		end

		def solve
			num_audience_seeds = 0

			@people_per_shyness_level.each_with_index do |item, index|

				for n in @people_per_shyness_level[index]..10
					standing = get_num_still_sitting
					if standing <= 0
						return num_audience_seeds
					end

					@people_per_shyness_level[index] += 1
					num_audience_seeds += 1
				end
			end
			num_audience_seeds
		end

		def get_num_still_sitting
			num_standing = 0
			@people_per_shyness_level.each_with_index do |item, index|
				if num_standing >= index
					num_standing += @people_per_shyness_level[index]
				end
			end
			sum = 0
			@people_per_shyness_level.each { |p| sum += p }
			sum - num_standing
		end
	end
end 

s = Solvy.new()
s.load_input
s.output_solution