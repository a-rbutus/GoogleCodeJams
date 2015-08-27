class Solvy 

	attr_accessor :testCases, :numTestCases

	def initialize(numTestCases, testCases)
		@numTestCases = numTestCases
		@testCases = testCases
	end

	def loadInput
		File.foreach("ovation-large.in") do |line|
  		 	if @numTestCases == 0
  		 		@numTestCases = line.to_i
  		 	else 
  		 		@testCases.push(Audience.new(line))
  		 	end 
	  	end
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

		def initialize(line)
			splitLine = line.split(' ')
			@maxShyness = splitLine[0].to_i
			@peoplePerShynessLevel = splitLine[1].to_s.chars.map(&:to_i)
		end

		def solve
			numAudienceSeeds = 0

			@peoplePerShynessLevel.each_with_index do |item, index|

				for n in @peoplePerShynessLevel[index]..10
					standing = getNumStillStanding
					if standing <= 0
						return numAudienceSeeds
					end

					@peoplePerShynessLevel[index] += 1
					numAudienceSeeds += 1
				end
			end
			numAudienceSeeds
		end

		def getNumStillStanding
			numStanding = 0
			@peoplePerShynessLevel.each_with_index do |item, index|
				if numStanding >= index
					numStanding += @peoplePerShynessLevel[index]
				end
			end
			sum = 0
			@peoplePerShynessLevel.each { |p| sum += p }
			sum - numStanding
		end
	end
end 

s = Solvy.new(0, Array.new)
s.loadInput
s.outputSolution