AllInstances = {}

Player = {}
Player.__index = Player

Objects = {}
Objects.__index = Objects

Obstacles = {}
Obstacles.__index = Obstacles
setmetatable(Obstacles, Objects)

function Player.new()
	local instance = setmetatable({}, Player)
	instance.x = 0
	instance.y = 0
	return instance
end

function Obstacles.new(x, y)
	local instance = setmetatable({}, Obstacles)
	instance.x = x
	instance.y = y
	return instance
end

function love.load()
	
	local MainPlayer = Player.new()
	AllInstances["MainPlayer"] = MainPlayer

end


function love.update(dt)

end
function love.draw()

end