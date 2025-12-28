PI = math.pi

Trig = {}
Trig.__index = Trig

Converters = {}
Converters.__index = Converters
setmetatable(Trig, Converters)

function Converters.DegreesToRadians(Degrees)
	return Degrees*(PI/180)
end

function love.load()

	local AllRadians = {}
	AllVertecies = {}
	
	for num1 = 0, 300, 60 do
		local NewNumber = Converters.DegreesToRadians(num1)
		
		local Cos = math.cos(NewNumber)
		local Sin = math.sin(NewNumber)
		
		AllRadians[tostring(num1)] = {Cos, Sin}
	end
	
	StartingVertex = {100, 100}
	
	for num1 = 0, 5, 1 do
		local SelectedAllRadians = tostring(num1*60)
		
		local SubTableCos = AllRadians[SelectedAllRadians][1]
		local SubTableSin = AllRadians[SelectedAllRadians][2]
		
		local NextCosPoint = (SubTableCos*StartingVertex[1])+StartingVertex[1]
		local NextSinPoint = (SubTableSin*StartingVertex[2])+StartingVertex[2]
		
		table.insert(AllVertecies, {NextCosPoint, NextSinPoint})
	end
end

function love.update(dt)
	
end

function love.draw()
	love.graphics.setColor(1, 1, 1, 1)
	
	local Sin = 2
	local Cos = 1
	
	for i, v in ipairs(AllVertecies) do
		local vv = AllVertecies[i+1]
		
		if vv then
			love.graphics.line(v[Cos], v[Sin], vv[Cos], vv[Sin])
		else
			love.graphics.line(AllVertecies[1][Cos], AllVertecies[1][Sin], AllVertecies[6][Cos], AllVertecies[6][Sin])
		end
	end
end