cWidth = 1080
cHeight = 640
cWeight = {["Obstacles"] = 2, ["Mobs"] = 1}

math.randomseed(os.time())

AllInstances = {}

Player = {}
Player.__index = Player

Objects = {}
Objects.__index = Objects

Obstacles = {}
Obstacles.__index = Obstacles
setmetatable(Obstacles, Objects)

Mobs = {}
Mobs.__index = Mobs
setmetatable(Mobs, Objects)

function Player.new()
	local instance = setmetatable({}, Player)
	instance.y = 500
	instance.size = 50
	instance.x = (cWidth/2)-(instance.size/2)
	instance.color = {1, 0.92156862745098, 0.23137254901961, 1}
	return instance
end

function Obstacles.new(x, y)
	local instance = setmetatable({}, Obstacles)
	instance.x = x
	instance.y = y
	instance.yDown = 100
	instance.color = {0.37647058823529, 0.49019607843137, 0.54509803921569, 1}
	instance.size = 50
	return instance
end

function Mobs.new(x, y)
	local instance = setmetatable({}, Mobs)
	instance.x = x
	instance.y = y
	instance.yDown = 100
	instance.xDown = 100
	instance.color = {0.80392156862745, 0.2156862745098, 0.23137254901961, 1}
	instance.size = 50
	return instance
end

function Weighter(dt)
	local Randomized = math.random(0, 99)
	if Randomized < cWeight["Mobs"] then
		Spawn(cWeight["Mobs"])
	elseif Randomized < cWeight["Obstacles"] then
		Spawn(cWeight["Obstacles"])
	end
end

function Spawn(number)
	local instance
	if number == cWeight["Obstacles"] then
		local X = math.random(10, cWidth-10)
		local Y = -50
		instance = Obstacles.new(X, Y)
	elseif number == cWeight["Mobs"] then
		local X = math.random(10, cWidth-10)
		local Y = -50
		instance = Mobs.new(X, Y)
	end
	table.insert(AllInstances, instance)
end

function love.load()
	
	DefaultFont = love.graphics.newFont(500)
	love.graphics.setFont(DefaultFont)
	Text = love.graphics.newText(DefaultFont, "You Have Died! Press G to Retry")
	
	local MainPlayer = Player.new()
	AllInstances["MainPlayer"] = MainPlayer
	
	DeathCondition = false

end

function Restarter()
	AllInstances["MainPlayer"] = Player.new()
	DeathCondition = false
end

function InputReciever(dt)
	local speed = 300
	local player = AllInstances["MainPlayer"]
	if love.keyboard.isDown("up") then
		player.y = player.y + ((speed * dt) * -1)
	end
	if love.keyboard.isDown("down") then
		player.y = player.y + (speed * dt)
	end
	if love.keyboard.isDown("left") then
		player.x = player.x + ((speed * dt) * -1)
	end
	if love.keyboard.isDown("right") then
		player.x = player.x + (speed * dt)
	end
	AllInstances["MainPlayer"] = player
end

function EntityMover(dt)
	local player = AllInstances["MainPlayer"]
	for i, v in pairs(AllInstances) do
		if v.xDown then
			local AbsoluteDistance = math.abs(v.x - player.x)
			if AbsoluteDistance > 5 and v.x < player.x then
				AllInstances[i].x = v.x + (v.xDown * dt)
			elseif AbsoluteDistance > 5 and v.x > player.x then
				AllInstances[i].x = v.x - (v.xDown * dt)
			end
			AllInstances[i].y = v.y + (v.yDown * dt)
		elseif i ~= "MainPlayer" then
			AllInstances[i].y = v.y + (v.yDown * dt)
		end
	end
end

function EntityExpunger()
	for i, v in pairs(AllInstances) do
		if i ~= "MainPlayer" and v.y > 640 then
			table.remove(AllInstances, i)
		end
	end
end

function DieChecker()
	local player = AllInstances["MainPlayer"]
	for i, v in pairs(AllInstances) do
		if i ~= "MainPlayer" then
			local X = math.abs((v.x + v.size/2) - (player.x + player.size/2))
			local Y = math.abs((v.y + v.size/2) - (player.y + player.size/2))
			
			if Y < v.size and X < v.size then
				player.color = {0, 0, 0, 0}
				DeathCondition = true
			end
		end
	end
end

function ExpungeAll()
	for i, _ in pairs(AllInstances) do
		AllInstances[i] = nil
	end
end

function love.update(dt)
	if not DeathCondition then
		InputReciever(dt)
		EntityMover(dt)
		Weighter(dt)
		EntityExpunger()
		DieChecker()
	else
		if #AllInstances > 0 then ExpungeAll(); print(#AllInstances .. " This is the number of instances after expunging") end
		if DeathCondition and love.keyboard.isDown("g") then
			Restarter()
		end
	end
end

function love.draw()
	if not DeathCondition then
		for i, v in pairs(AllInstances) do
			print(i .. " " .. tostring(v))
			love.graphics.setColor(v.color[1], v.color[2], v.color[3], v.color[4])
			love.graphics.rectangle("fill", v.x, v.y, v.size, v.size)
		end
	else
		love.graphics.draw(Text, 100, 100, 0, 0.05)
	end
end