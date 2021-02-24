local mod = RegisterMod("More Dice", 1)

local i = {
	DNeg1 = "D Negative 1",
	D0 = "D0",
	DHalf = "D0.5",
	DOtherHalf = "D Other 0.5",
	D2 = "D2",
	D3 = "D3",
	D5 = "D5",
	D9 = "D9",
	D11 = "D11",
	D13 = "D13",
	D14 = "D14",
	D15 = "D15",
	D16 = "D16",
	D17 = "D17"
}

local v = {
	d17Luck = 0
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
	62,63,64,65,66,67,68,69,71,72,73,74,75,76,77,78,79,
	81,82,83,84,
	97,98,99,100,101,102,
	260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,
	401,402,403,404,405,406,407,408,409,410,411,412,413
}

local flyNumbers = {
	13,14,18,25,61,80,91,
	214,222,249,256,
	281,296
}

local debugLog = {}

local function addLog(text, index)
    index = index or #debugLog + 1
    for i = 1, index do
        if not debugLog[i] then
            debugLog[i] = ""
        end
    end

    debugLog[index] = tostring(text)
end

local itemConfig = Isaac.GetItemConfig()
local numCollectibles = #itemConfig:GetCollectibles()

local zeroVector = Vector(0, 0)

local ents
local enemies
local level
local room
local player
local game = Game()
local invStuff = {}
local api
local rng = RNG()

local function convert(tbl, contentType)
    local ret = {}
    for k, v in pairs(tbl) do
        local id
        if contentType == "I" then
            id = Isaac.GetItemIdByName(v)
        -- elseif contentType == "T" then
        --     id = Isaac.GetTrinketIdByName(v)
        -- elseif contentType == "ET" then
        --     id = Isaac.GetEntityTypeByName(v)
        -- elseif contentType == "EV" then
        --     id = Isaac.GetEntityVariantByName(v)
        -- elseif contentType == "S" then
        --     id = Isaac.GetSoundIdByName(v)
        -- elseif contentType == "P" then
        --     id = Isaac.GetPillEffectByName(v)
        end

        if id ~= -1 then
            ret[k] = id
        else
            Isaac.DebugString(k .. " invalid name!")
            ret[k] = id
        end
    end

    return ret
end

i = convert(i, "I")
-- t = convert(t, "T")
-- et = convert(et, "ET")
-- ev = convert(ev, "EV")
-- s = convert(s, "S")
-- pi = convert(pi, "P")

local function onActiveUse(id, fn)
    mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, ...)
        return fn(...)
    end, id)
end

local function onPassiveTick(id, fn)
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, p, ...)
        if p:HasCollectible(id) then
            return fn(p, ...)
        end
    end)
end

local itemsToCheck = {}

local function onItemPickup(id, fn, remove)
    if type(id) == "table" then
        for _, i in ipairs(id) do
            onItemPickup(i, fn, remove)
        end
    else
        itemsToCheck[#itemsToCheck + 1] = {
            ID = id,
            FN = fn,
            Remove = remove
        }
    end
end

local function TriggerRoomAmbush(...)
	room = game:GetRoom()
	roomClosed = false
	for i = 0, 7 do
	    local GridEntityDoor = room:GetDoor(i)
	    if GridEntityDoor then
	        GridEntityDoor = GridEntityDoor:ToDoor()
	        GridEntityDoor:Close(true)
	    end
	end
	roomClosed = true
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    player = Isaac.GetPlayer(0)
	room = game:GetRoom()
    for _, itemStuff in ipairs(itemsToCheck) do
        local id, fn, remove = itemStuff.ID, itemStuff.FN, itemStuff.Remove
        if id ~= -1 then
            local numCollect = player:GetCollectibleNum(id)
            local before = 0
            if invStuff[id] then
                before = invStuff[id]
            else
                invStuff[id] = before
            end

            local diff = math.abs(numCollect - before)

            if diff > 0 then
                for i = 1, diff do
                    if (numCollect > before) and fn then
                        fn(player)
                    elseif (numCollect < before) and remove then
                        remove(player)
                    end
                end
            end
        end
    end

    for _, itemStuff in ipairs(itemsToCheck) do
        local numCollect = player:GetCollectibleNum(itemStuff.ID)
        invStuff[itemStuff.ID] = numCollect
    end

	if roomClosed and room:GetAliveEnemiesCount() == 0 then
		room:SpawnClearAward()
		roomClosed = false
	end
end)

local function getInventory()
    local inv = {}
    for i = 1, numCollectibles do
        if itemConfig:GetCollectible(i) then
            inv[i] = player:GetCollectibleNum(i)
        end
    end
    return inv
end

local function BossOrMonster(entityInt, bossTrue)
	local isMonster = false
	local isBoss = false
	local listToCheck
	if bossTrue then
		listToCheck = bossNumbers
	else
		listToCheck = enemyNumbers
	end
	for i,v in pairs(listToCheck) do
		if entityInt == v then
			if bossTrue then
				isBoss = true
			else
				isMonster = true
			end
		end
	end
	if bossTrue then
		return isBoss
	else
		return isMonster
	 end
end

local function GenerateRandomEnemy()
	local monster = rng:RandomInt(404) + 10
	if BossOrMonster(monster, false) then
		return monster
	else
		return GenerateRandomEnemy()
	end
end

local function GenerateRandomBoss()
	local boss = rng:RandomInt(404) + 10
	if BossOrMonster(boss, true) then
		return boss
	else
		return GenerateRandomBoss()
	end
end

function mod:EvaluateCache(p, cacheFlag)
	if cacheFlag == CacheFlag.CACHE_LUCK then
		p.Luck = p.Luck + v.d17Luck
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
    invStuff = {}
    v.d17Luck = 0
end)

--dice activation code
onActiveUse(i.DNeg1, function()
	room = game:GetRoom()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in pairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLACK_HOLE, 0, room:FindFreePickupSpawnPosition(entity.Position, 0, true), Vector(0,0), entity)
			entity:Remove()
		end
	end

	return true
end)

onItemPickup(i.D0, function()
	if player:HasCollectible(i.D0) then
		player:RemoveCollectible(i.D0)
	end
end)

onActiveUse(i.DHalf, function()
	room = game:GetRoom()
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

	return true
end)

onActiveUse(i.DOtherHalf, function()
	room = game:GetRoom()
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

	return true
end)

onActiveUse(i.D2, function()
	local flip = rng:RandomInt(2)
	if flip == 0 then
		game:End(2)
	elseif flip == 1 then
		game:End(1)
	end

	return true
end)

onActiveUse(i.D3, function()
	room = game:GetRoom()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in pairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_PICKUP
			and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, room:FindFreePickupSpawnPosition(entity.Position, 0, true), Vector(0,0), entity)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 0, room:FindFreePickupSpawnPosition(entity.Position, 0, true), Vector(0,0), entity)
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, 0, room:FindFreePickupSpawnPosition(entity.Position, 0, true), Vector(0,0), entity)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.D5, function()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in ipairs(roomEntities) do
		if entity:IsBoss() then
			Isaac.Spawn(GenerateRandomEnemy(), 0, 0, entity.Position, Vector(0,0), entity)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.D9, function()
	local floor = rng:RandomInt(12) + 1
	local sub = rng:RandomInt(3)
	local level = game:GetLevel()
	level:SetStage(floor, sub)
	game:StartStageTransition(true, 1)

	return true
end)

onActiveUse(i.D11, function()
	room = game:GetRoom()
	local inv = getInventory()
	local allHeld = {}
	for id, numOwned in pairs (inv) do
		if numOwned > 0 then
			for i = 1, numOwned do
				allHeld[#allHeld + 1] = id
			end
		end
	end

	for i, v in pairs (allHeld) do
		player:RemoveCollectible(v)
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, 0, room:FindFreePickupSpawnPosition(player.Position, 0, true), Vector(0,0), player)
	end

	return true
end)

onActiveUse(i.D13, function()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in ipairs(roomEntities) do
		if entity:IsEnemy() and not entity:IsBoss() then
			Isaac.Spawn(GenerateRandomBoss(), 0, 0, entity.Position, Vector(0,0), entity)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.D14, function()
	room = game:GetRoom()
	if room:IsClear() and not roomClosed then
		Isaac.Spawn(13, 0, 0, room:GetCenterPos(), Vector(0,0), nil)
		TriggerRoomAmbush()
	end

	return true
end)

onActiveUse(i.D15, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_TEAR then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, 0, 0, entity.Position, entity.Velocity, nil)
			entity:Remove()
		end
	end
end)

onActiveUse(i.D16, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		for i, fly in pairs(flyNumbers) do
			if entity.Type == fly then
				Isaac.Spawn(flyNumbers[rng:RandomInt(#flyNumbers)+1], 0, 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
		end
	end
end)

--TODO: reformat this function and all cache evaluation functions to be more
--in line with abortionbirth standards
onActiveUse(i.D17, function()
	local entities = Isaac.GetRoomEntities()
	player = Isaac.GetPlayer(0)
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PROJECTILE then
			v.d17Luck = v.d17Luck + 1
			entity:Remove()
		end
	end
	player:AddCacheFlags(CacheFlag.CACHE_LUCK)
	player:EvaluateItems()
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EvaluateCache)
