
function generateRandomPopulation() 
	local population = {}	
	math.randomseed(os.time())
	for i=1,200 do
		table.insert(genome,{})
		for j=0,19682 do
			population[i][j] = math.random(0,8)
		end	
	end
	return population
end

function makeNewGeneration(population)
	local newGeneration = {}
	for i=0,table.getn(population) do
		for j=0,table.getn(population) do
			
		end
	end
	return newGeneration
end

function reproduction(a,b)
	for i=0,table.getn() do
	end
end

function naturalSelection()
end

