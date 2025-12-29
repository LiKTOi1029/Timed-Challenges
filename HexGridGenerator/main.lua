PI = math.pi
AllHexagons = {}

function DegreesToSinAndCos(Degrees)
	return math.cos(Degrees*(PI/180)), math.sin(Degrees*(PI/180))
end

function Hexagon(StartingPoint, Location)
	local AllPointData = {}
	local XPos, YPos = Location[1], Location[2]
	for degrees = 0, 300, 60 do
		local Cos, Sin = DegreesToSinAndCos(degrees)
		local NewCos, NewSin = (Cos*StartingPoint[1])+StartingPoint[1]+XPos, (Sin*StartingPoint[2])+StartingPoint[2]+YPos
		table.insert(AllPointData, {NewCos, NewSin})
	end
	table.insert(AllHexagons, AllPointData)
end

function DrawHexagons()
	love.graphics.setColor(1, 1, 1, 1)
	for i, v in ipairs(AllHexagons) do
		for i2, v2 in ipairs(v) do
			local vv = v[i2+1]
			if vv then
				love.graphics.line(v2[1], v2[2], vv[1], vv[2])
			else
				love.graphics.line(v2[1], v2[2], v[1][1], v[1][2])
			end
		end
	end
end

function LoadHexagons()
	local cStartingPoint = {50, 50} -- This is a const, don't change it
	local Cos, Sin = DegreesToSinAndCos(60)
	local HexagonSize = 100
	for y = 0, 5, 1 do
		for x = 0, 9, 1 do
			local YPos
			local XPos
			if x % 2 == 0 then
				XPos = x*(HexagonSize*Cos)+((HexagonSize/4)*x)
				YPos = y*(HexagonSize*Sin)
			else
				XPos = x*(HexagonSize*Cos)+((HexagonSize/4)*x)
				YPos = y*(HexagonSize*Sin)+(HexagonSize*(Sin/2))
			end
			Hexagon(cStartingPoint, {XPos, YPos})
		end
	end
end

function love.load()
	LoadHexagons()
end

function love.update()

end

function love.draw()
	DrawHexagons()
end