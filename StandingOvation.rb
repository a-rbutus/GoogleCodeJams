class Solvy 

	attr_accessor :testCases, :numTestCases

	def initialize(numTestCases, testCases)
		@numTestCases = numTestCases
		@testCases = testCases
	end

	def loadInput
		File.foreach("ovation.in") do |line|
  		 	if @numTestCases == 0
  		 		@numTestCases = line.to_i
  		 	else 
  		 		@testCases.push(Audience.new(line))
  		 	end 
	  	end
	end
	
	def to_s
    	"Solvy: #{@numTestCases}-- (#{@testCases})\n"
  	end

  	def outputSolution

		solution = ""
  		@testCases.each_with_index do |item, index|
  			solution << "Case ##{index + 1}: #{item.solve}\n"
  		end

		File.open("ovationOutput.txt", 'w') { |file| file.write(solution) }

  	end

	class Audience

		@maxShyness
		@peoplePerShynessLevel
		@totalPeople

		def initialize(line)
			
			splitLine = line.split(' ')

			@maxShyness = splitLine[0].to_i
			@peoplePerShynessLevel = splitLine[1].to_s.chars.map(&:to_i)

			@totalPeople = 0
			@peoplePerShynessLevel.each { |p| @totalPeople+= p }

		end

		def solve

			numAudienceSeeds = 0

			@peoplePerShynessLevel.each_with_index do |item, index|

				numLeft = numLeftSitting
				if numLeftSitting = 0
					return numAudienceSeeds

				elsif @peoplePerShynessLevel[index] < 9

					if 

						@peoplePerShynessLevel[index] += 1
						numAudienceSeeds += 1
				end
			end

			numAudienceSeeds
		end

		def numLeftSitting 

			numStanding = 0
			@peoplePerShynessLevel.each_with_index do |item, index|
				if numStanding >= index
					numStanding += @peoplePerShynessLevel[index]
				end
			end
			@totalPeople - numStanding
		end

		def to_s
			"#{@totalPeople}: #{@peoplePerShynessLevel}"
		end

	end

end 

s = Solvy.new(0, Array.new)
s.loadInput
s.outputSolution