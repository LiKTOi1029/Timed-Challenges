PlayerX, PlayerY = 2, 2
TileTable = {{0,0,0},{0,0,0},{0,0,0}}

function ShowMap()
	for Number, Value in ipairs(TileTable) do
		for Index = 1, TileTable[Number], 1 do
			if PlayerY == Number and PlayerX == Index then
				io.write("1")
			else
				io.write(tostring(TileTable[Index]))
			end
		end
		io.write("\n")
	end
end

function Decider(choice)
	if choice:upper() == "TL" then 
		PlayerX = PlayerX - 1
		PlayerY = PlayerY - 1
	elseif choice:upper() == "TR" then
		PlayerX = PlayerX + 1
		PlayerY = PlayerY - 1
	elseif choice:upper() == "BR" then
		PlayerX = PlayerX + 1
	elseif choice:upper() == "BL" then
		PlayerX = PlayerX - 1
	elseif choice:upper() == "U" then
		PlayerY = PlayerY - 1
	elseif choice:upper() == "D" then
		PlayerY = PlayerY + 1
	else
		return print("Invalid Movement")
	end
end

repeat
	ShowMap()
	io.write("Type TR, TL, BL, BR, U, or D to move your player")
	local choice = io.read():gsub("\n", "")
	Decider(choice)
until choice:upper() == "EXIT"