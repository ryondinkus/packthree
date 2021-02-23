local moreDice = RegisterMod("More Dice", 1)
local game = Game()
local rng = RNG()
local player
--dice
local i = {
	DNeg1 = Isaac.GetItemIdByName("D Negative 1"),
	D0 = Isaac.GetItemIdByName("D0"),
	DHalf = Isaac.GetItemIdByName("D0.5"),
	DOtherHalf = Isaac.GetItemIdByName("D Other 0.5"),
	D2 = Isaac.GetItemIdByName("D2"),
	D3 = Isaac.GetItemIdByName("D3"),
	D5 = Isaac.GetItemIdByName("D5"),
	D9 = Isaac.GetItemIdByName("D9"),
	D11 = Isaac.GetItemIdByName("D11")
}

local flags = {
	hasD0 = false
}

local enemyNumbers = { --entity numbers corresponding to enemies
	10,11,12,13,14,15,16,
	18,
	21,22,23,24,25,26,27,
	29,30,31,32,
	34,35,
	38,39,40,41,42,
	44,
	53,54,55,56,57,58,59,60,61,
	80,
	85,86,87,88,89,90,91,92,93,94,
	201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,
	220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,
	239,240,241,242,243,244,
	246,247,248,249,250,251,252,253,254,255,256,257,258,259,
	276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,
	295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310
}

local bossNumbers = { --entity numbers corresponding to bosses
	19,20,
	28,
	36,
	43,
	45,46,47,48,49,50,51,52,
	62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,
	81,82,83,84,
	97,98,99,100,101,102,
	260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,
	401,402,403,404,405,406,407,408,409,410,411,412,413
}

local itemConfig = Isaac.GetItemConfig()
local numCollectibles = #itemConfig:GetCollectibles()

--dice activation code
function moreDice:DNeg1Use()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in pairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLACK_HOLE, 0, entity.Position, Vector(0,0), entity)
			entity:Remove()
		end
	end
end

function moreDice:DHalfUse()
	local currentRoom = game:GetRoom()
	local gridSize = currentRoom:GetGridSize()
	local gridEnd = math.floor(gridSize/2)
	for i=0,gridEnd,1 do
		local currentGrid = currentRoom:GetGridEntity(i)
		if currentGrid ~= nil then
			if currentGrid:GetType() ~= 16 then
				currentGrid:Destroy(true)
			end
		end
	end
end

function moreDice:DOtherHalfUse()
	local currentRoom = game:GetRoom()
	local gridSize = currentRoom:GetGridSize()
	local gridStart = math.floor(gridSize/2)
	for i=gridStart,gridSize,1 do
		local currentGrid = currentRoom:GetGridEntity(i)
		if currentGrid ~= nil then
			if currentGrid:GetType() ~= 16 then
				currentGrid:Destroy(true)
			end
		end
	end
end

function moreDice:D2Use()
	local flip = rng:RandomInt(2)
	if flip == 0 then
		game:End(2)
	elseif flip == 1 then
		game:End(1)
	end
end

function moreDice:D3Use()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in pairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_PICKUP
			and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, entity.Position, Vector(0,0), entity)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, entity.Position, Vector(0,0), entity)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, entity.Position, Vector(0,0), entity)
			entity:Remove()
		end
	end
end

function GenerateRandomEnemy()
	local monster = rng:RandomInt(404) + 10
	if CheckForMonster(monster) then
		return monster
	else
		return GenerateRandomEnemy()
	end
end

function CheckForMonster(entityInt)
	local isMonster = false
	for i,v in pairs(enemyNumbers) do
		if entityInt == v then
			isMonster = true
		end
	end
	return isMonster
end

function GenerateRandomBoss()
	local boss = rng:RandomInt(404) + 10
	if boss:IsBoss() then
		return boss
	else
		GenerateRandomBoss()
	end
end

function moreDice:D5Use()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in ipairs(roomEntities) do
		if entity:IsBoss() then
			Isaac.Spawn(GenerateRandomEnemy(), 0, 0, entity.Position, Vector(0,0), entity)
			entity:Remove()
		end
	end
end

function moreDice:D9Use()
	local floor = rng:RandomInt(12) + 1
	local sub = rng:RandomInt(3)
	local level = game:GetLevel()
	level:SetStage(floor, sub)
	game:StartStageTransition(true, 1)
end

function GetCollection()
	player = Isaac.GetPlayer(0)
	local inv = {}
	for i = 1, numCollectibles do
		inv[i] = player:GetCollectibleNum(i)
	end
	return inv
end


function moreDice:D11Use()
	player = Isaac.GetPlayer(0)
	local inv = GetCollection()
	for i,v in pairs(inv) do
		player:RemoveCollectible(v)
	end
end

function moreDice:onUpdate(player)
	if player:HasCollectible(i.D0) then
		player:RemoveCollectible(i.D0)
	end
end

moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.DNeg1Use, i.DNeg1)
moreDice:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, moreDice.onUpdate)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.DHalfUse, i.DHalf)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.DOtherHalfUse, i.DOtherHalf)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.D2Use, i.D2)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.D3Use, i.D3)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.D5Use, i.D5)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.D9Use, i.D9)
moreDice:AddCallback(ModCallbacks.MC_USE_ITEM, moreDice.D11Use, i.D11)
