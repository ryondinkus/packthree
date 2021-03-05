local mod = RegisterMod("Unpentance", 1)
local rng = RNG()

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
	D17 = "D17",
	D18 = "D18",
	D19 = "D19",
	D21 = "D21",
	D22 = "D22",
	D23 = "D23",
	D69 = "D69",
	D99 = "D99",
	D120 = "D120",
	D666 = "D666",
	D1337 = "D1337",
	D2K = "D2K",
	DF = "DF",
	FlatD6 = "Flat D6",
	PassiveD6 = "PassiveD6"
}

local pi = {
	MaggyUp = "Maggy Up",
	Deafness = "Deafness",
	HorfHorf = "Horf...Horf!",
	Megacraft = "Megacraft",
	HourEnergy = "1 Hour Energy!",
	DamageDown = "Damage Down",
	SleepParalysis = "Sleep Paralysis",
	ThreeExclamations = "!!!",
	ThreeDots = "..."
}

local et = {
	Muro = "Muro",
	LittlestHorn = "Littlest Horn"
}

local ev = {
	Muro = "Muro",
	Nostro = "Nostro",
	Tomato = "Tomato",
	Sickstro = "Sickstro",
	LittlestHorn = "Littlest Horn",

	MoreJellyBean = "Jelly Bean Inverted",
	RustedPenny = "Rusted Penny",
	RustedKey = "Rusted Key",
	RustedBomb = "Rusted Bomb",
	RustedHeart = "Rusted Heart",
	RustedBattery = "Rusted Battery"
}

local es = {
	Logo = 1
}

local f = {
	deaf = false
}

local t = {
	reallylazyworm = "REALLY Lazy Worm"
}

local d17Stats = {
	Luck = 0
}

local d21Stats = {
	Damage = 0,
	MaxFireDelay = 0,
	ShotSpeed = 0,
	Luck = 0,
	MoveSpeed = 0
}

local d21Info = {
	flag1 = "",
	flag2 = "",
	used = false
}

local RLWInfo = {
	Range = 120.00,
	ShotSpeed = 0.60
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
	220,221,222,223,224,225,226,227,228,229,230,231,233,234,235,236,237,238,
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
	401,402,403,404,405,406,407,408,409,410,411,412,413,
	Isaac.GetEntityTypeByName("Nerve Ending 3"), Isaac.GetEntityTypeByName("Mega Ultra Envy"),
	Isaac.GetEntityTypeByName("Medium Horn"), Isaac.GetEntityTypeByName("Santa"),
	Isaac.GetEntityTypeByName("Ultra Envy"), Isaac.GetEntityTypeByName("Skinless Hush"),
	Isaac.GetEntityTypeByName("Abortionbirth SECRET BOSS"), LittlestHorn
}

local flyNumbers = {
	13,14,18,25,61,80,91,
	214,222,249,256,
	281,296,
	Isaac.GetEntityTypeByName("Green Attack Fly")
}

local familiarNumbers = {
	8,10,57,67,73,88,94,95,96,98,99,100,112,113,117,131,144,155,163,167,170,172,
	174,178,187,188,207,238,239,264,265,266,267,268,269,270,271,272,273,274,275,
	276,277,278,279,280,281,318,319,320,321,322,360,361,362,363,364,365,372,375,
	384,385,387,388,389,390,403,404,405,412,413,417,426,430,431,433,435,436,467,
	468,469,470,471,472,473,474,491,492,500,508,509,511,518,519,526,528,537,539,
	542,543,544,548,
	Isaac.GetItemIdByName("Bean Bum"),Isaac.GetItemIdByName("Biggest Fan"),
	Isaac.GetItemIdByName("Bob's Brain II"),Isaac.GetItemIdByName("Devil Bum"),
	Isaac.GetItemIdByName("Guppy Bum"),Isaac.GetItemIdByName("Pack 2 Sack"),
	Isaac.GetItemIdByName("Rocket Boy"),Isaac.GetItemIdByName("Sack of Beans"),
	Isaac.GetItemIdByName("Sack of Charge"),Isaac.GetItemIdByName("Sack of Diamonds"),
	Isaac.GetItemIdByName("Sack of Nothing"),Isaac.GetItemIdByName("Sack of Rockets"),
	Isaac.GetItemIdByName("Sack of Sack of Sacks"),Isaac.GetItemIdByName("Sacrificial Bean"),
	Isaac.GetItemIdByName("Skinless ???'s Body'"),Isaac.GetItemIdByName("Skinless Hushy"),
	Isaac.GetItemIdByName("The Ghost")
}

local flagStuff = {
    MoveSpeed = CacheFlag.CACHE_SPEED,
    Damage = CacheFlag.CACHE_DAMAGE,
    MaxFireDelay = CacheFlag.CACHE_FIREDELAY,
    ShotSpeed = CacheFlag.CACHE_SHOTSPEED,
    TearFlags = CacheFlag.CACHE_TEARFLAG,
    TearFallingSpeed = CacheFlag.CACHE_RANGE,
    TearFallingAcceleration = CacheFlag.CACHE_RANGE,
    TearHeight = CacheFlag.CACHE_RANGE,
    LaserColor = CacheFlag.CACHE_TEARCOLOR,
    TearColor = CacheFlag.CACHE_TEARCOLOR,
	Luck = CacheFlag.CACHE_LUCK
}

local d21Flags = {
	CacheFlag.CACHE_SPEED,
	CacheFlag.CACHE_DAMAGE,
	CacheFlag.CACHE_FIREDELAY,
	CacheFlag.CACHE_LUCK,
	CacheFlag.CACHE_SHOTSPEED
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
local sfx = SFXManager()
local mus = MusicManager()

local function convert(tbl, contentType)
    local ret = {}
    for k, v in pairs(tbl) do
        local id
        if contentType == "I" then
            id = Isaac.GetItemIdByName(v)
        elseif contentType == "T" then
        	id = Isaac.GetTrinketIdByName(v)
        elseif contentType == "ET" then
        	id = Isaac.GetEntityTypeByName(v)
        elseif contentType == "EV" then
        	id = Isaac.GetEntityVariantByName(v)
         -- elseif contentType == "S" then
         --     id = Isaac.GetSoundIdByName(v)
        elseif contentType == "P" then
             id = Isaac.GetPillEffectByName(v)
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
t = convert(t, "T")
et = convert(et, "ET")
ev = convert(ev, "EV")
--s = convert(s, "S")
pi = convert(pi, "P")

local function apiStart()
    api = InfinityBossAPI
    api.AddBossToPool("gfx/bossui/portrait_littlesthorn.png", "gfx/bossui/bossname_littlesthorn.png", et.LittlestHorn, ev.LittlestHorn, 0, LevelStage.STAGE1_1, nil, 50, nil, nil, nil)
	api.AddBossToPool("gfx/bossui/portrait_littlesthorn.png", "gfx/bossui/bossname_littlesthorn.png", et.LittlestHorn, ev.LittlestHorn, 0, LevelStage.STAGE1_1, nil, 50, nil, nil, nil)
end

local function applyStupidStats(p, flag, stupidStats)
    for key, val in pairs(stupidStats) do
        local keyLen = string.len(key)
        local lastTwoChars = string.sub(key, keyLen - 1)
        local notLastTwoChars = string.sub(key, 1, keyLen - 2)
        local check = key
        if lastTwoChars == "Eq" or lastTwoChars == "Mu" then
            check = notLastTwoChars
        end

        if p[check] and flag == flagStuff[check] then
            if check == "TearFlags" then
                p[check] = p[check] | val
            elseif lastTwoChars == "Eq" then
                p[check] = val
            elseif lastTwoChars == "Mu" then
                if check == "MaxFireDelay" then
                    p[check] = math.floor(p[check] * val)
                else
                    p[check] = p[check] * val
                end
            else
                p[check] = p[check] + val
            end
        end
    end
end

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

local function whenVar(name, fn, is)
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
        if f[name] and (not is or f[name] == is) then
            fn()
        end
    end)
end

local function onEntityTick(type, fn, variant, subtype)
    mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
        local found = Isaac.FindByType(type, variant or -1, subtype or -1, false, false)
        for _, ent in ipairs(found) do
            fn(ent)
        end
    end)
end

local function onTrinketTick(id, fn)
    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, p, ...)
        if p:HasTrinket(id) then
            return fn(p, ...)
        end
    end)
end

local function onPillUse(id, fn)
    mod:AddCallback(ModCallbacks.MC_USE_PILL, fn, id)
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

local function getNearestEnemy(pos)
    local dist
    local near
    for _, ent in ipairs(enemies) do
        local distance = ent.Position:Distance(pos or player.Position)
        if not dist or distance < dist then
            dist = distance
            near = ent
        end
    end

    return near
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function ()
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

local function replaceEntity(type, variant, subtype, type2, variant2, subtype2, chance)
    mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, type3, variant3, subtype3, position, velocity, spawner, seed)
        if (not type or type3 == type) and (not variant or variant3 == variant) and (not subtype or subtype3 == subtype) and (not chance or (rng:RandomInt(chance) == 0)) then
            return {type2, variant2, subtype2, seed}
        end
    end)
end

local function entsCollide(ent1, ent2)
    return ent1.Position:Distance(ent2.Position) <= (ent1.Size + ent2.Size)
end

local function onPickupPickup(variant, fn)
    mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, p, ...)
        if p.Variant == variant then
            local sprite, data = p:GetSprite(), p:GetData()
            if entsCollide(p, player) and not sprite:IsPlaying("Collect") and not sprite:IsFinished("Collect") and not sprite:IsPlaying("Appear") then
                local ret = fn(p, player)
                if ret ~= false then
                    sprite:Play("Collect")
                end
            end

            if sprite:IsFinished("Collect") then
                p:Remove()
            end
        end
    end)
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

local TextStreakQueue = {

}

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
    level = game:GetLevel()
    room = game:GetRoom()
    player = Isaac.GetPlayer(0)
    if f.RustedPenny then
        f.RustedPenny = false
    end
	if f.RustedKey then
		f.RustedKey = false
	end
	if f.RustedBomb then
		f.RustedBomb = false
	end
	if f.RustedHeart then
		f.RustedHeart = false
	end
	if f.RustedBattery then
		f.RustedBattery = false
	end
end)


mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	player = Isaac.GetPlayer(0)
    invStuff = {}
	d17Stats.Luck = 0
	d21Info.used = false
	f.deaf = false
	f.DamageDownTimesUsed = 0
	mus:Enable()
	player:AddCacheFlags(CacheFlag.CACHE_ALL)
	player:EvaluateItems()
end)

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if Isaac.GetItemIdByName("One True Bean") == -1 then
		Isaac.RenderText("Hey, it looks like you aren't using Abortionbirth Pack 2,", 100, 40, 255, 255, 255, 1)
		Isaac.RenderText("which this mod NEEDS. Please go download it :)", 100, 50, 255, 255, 255, 1)
	end
end)

--dice activation code
onActiveUse(i.DNeg1, function()
	room = game:GetRoom()
	local roomEntities = Isaac.GetRoomEntities()
	for i, entity in pairs(roomEntities) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLACK_HOLE, 0, entity.Position, Vector(0,0), entity)
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
	local gridSize = room:GetGridSize()
	local gridEnd = math.floor(gridSize/2)
	for i=0,gridEnd,1 do
		local currentGrid = room:GetGridEntity(i)
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
	local gridSize = room:GetGridSize()
	local gridStart = math.floor(gridSize/2)
	for i=gridStart,gridSize,1 do
		local currentGrid = room:GetGridEntity(i)
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

	return true
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

	return true
end)

--TODO: reformat this function and all cache evaluation functions to be more
--in line with abortionbirth standards
onActiveUse(i.D17, function()
	local entities = Isaac.GetRoomEntities()
	player = Isaac.GetPlayer(0)
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PROJECTILE then
			d17Stats.Luck = d17Stats.Luck + 1
			entity:Remove()
		end
	end
	player:AddCacheFlags(CacheFlag.CACHE_LUCK)
	player:EvaluateItems()

	return true
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, p, flag)
	if d17Stats.Luck > 0 then
		applyStupidStats(p, flag, d17Stats)
	end
end)

onActiveUse(i.D18, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP and
		entity.Variant == PickupVariant.PICKUP_PILL then
			Isaac.Spawn(EntityType.ENTITY_HUSH, 0, 0, entity.Position, Vector(0, 0), nil)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.D19, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			entity:Remove()
		end
	end

	return true
end)

local function FlagToStat(flag)
	if flag == CacheFlag.CACHE_DAMAGE then
		return "Damage"
	end
	if flag == CacheFlag.CACHE_FIREDELAY then
		return "MaxFireDelay"
	end
	if flag == CacheFlag.CACHE_LUCK then
		return "Luck"
	end
	if flag == CacheFlag.CACHE_SPEED then
		return "MoveSpeed"
	end
	if flag == CacheFlag.CACHE_SHOTSPEED then
		return "ShotSpeed"
	end
	return nil
end

onActiveUse(i.D21, function()
	d21Info.used = true
	local flag1 = d21Flags[rng:RandomInt(4)+1]
	local flag2 = d21Flags[rng:RandomInt(4)+1]
	while flag1 == flag2 do
		flag2 = d21Flags[rng:RandomInt(4)+1]
	end
	local stat1 = FlagToStat(flag1)
	local stat2 = FlagToStat(flag2)
	d21Stats[stat1] = 9
	d21Stats[stat2] = 10
	player:AddCacheFlags(flag1 | flag2)
	player:EvaluateItems()

	player:RemoveCollectible(i.D21)

	return true
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, p, flag)
	if d21Info.used == true then
		applyStupidStats(p, flag, d21Stats)
	end
end)

onActiveUse(i.D22, function()
	room = game:GetRoom()
	for i = 0, 7 do
	    local GridEntityDoor = room:GetDoor(i)
	    if GridEntityDoor then
	        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, GridEntityDoor.Position, Vector(0,0), nil)
			room:RemoveDoor(i)
	    end
	end
end)

onActiveUse(i.D23, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity:IsEnemy() and not entity:IsBoss() then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WORM, 0, entity.Position, Vector(0,0), nil)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.D69, function()
	room = game:GetRoom()
	local inv = getInventory()
	local allHeld = {}
	local bozos = 0
	for id, numOwned in pairs (inv) do
		if numOwned > 0 then
			for i = 1, numOwned do
				allHeld[#allHeld + 1] = id
			end
		end
	end

	for i, v in pairs (allHeld) do
		player:RemoveCollectible(v)
		bozos = bozos + 1
	end

	for i=1, bozos do
		player:AddCollectible(CollectibleType.COLLECTIBLE_BOZO, 0, false)
	end

	return true
end)

onActiveUse(i.D99, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			if entity.Variant == PickupVariant.PICKUP_KEY then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_GOLDEN, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
			if entity.Variant == PickupVariant.PICKUP_BOMB then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_GOLDEN, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
			if entity.Variant == PickupVariant.PICKUP_HEART then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_GOLDEN, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
			if entity.Variant == PickupVariant.PICKUP_COIN then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, Isaac.GetEntityVariantByName("Gold Penny"), 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
			if entity.Variant == PickupVariant.PICKUP_LIL_BATTERY then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, Isaac.GetEntityVariantByName("Golden Battery"), 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
			if entity.Variant == PickupVariant.PICKUP_GRAB_BAG then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, Isaac.GetEntityVariantByName("Golden Sack"), 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
			if entity.Variant == PickupVariant.PICKUP_CHEST then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LOCKEDCHEST, 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
		end
	end

	return true
end)

onActiveUse(i.D120, function()
	room = game:GetRoom()
	local inv = getInventory()
	local allHeld = {}
	local itemsToGive = {}
	for id, numOwned in pairs (inv) do
		if numOwned > 0 then
			for i = 1, numOwned do
				allHeld[#allHeld + 1] = id
			end
		end
	end

	for i, v in pairs (allHeld) do
		for j, w in pairs(familiarNumbers) do
			if v == w then
				newFamiliar = familiarNumbers[rng:RandomInt(#familiarNumbers)+1]
				table.insert(itemsToGive, newFamiliar)
				player:RemoveCollectible(v)
			end
		end
	end

	for i, v in pairs(itemsToGive) do
		player:AddCollectible(v, 0, false)
	end

	return true
end)

onActiveUse(i.D666, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP
		and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			newEnemy = enemyNumbers[rng:RandomInt(#enemyNumbers)+1]
			Isaac.Spawn(newEnemy, 0, 0, entity.Position, Vector(0,0), nil)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.D1337, function()
	local x = 0
	while x >= 0 do
		Isaac.Spawn(EntityType.ENTITY_DELIRIUM, 0, 0, room:FindFreePickupSpawnPosition(Vector(0,0), 0, true), Vector(0,0), nil)
		x = x + 1
	end
end)

onActiveUse(i.D2K, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity:IsEnemy() then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, entity.Position, Vector(0,0), nil)
			entity:Remove()
		end
	end

	return true
end)

onActiveUse(i.DF, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			for i = 1, 5 do
				Isaac.Spawn(entity.Type, entity.Variant, entity.SubType, room:FindFreePickupSpawnPosition(entity.Position, 0, true), entity.Velocity, nil)
			end
		end
		if entity:IsEnemy() then
			for i = 1, 5 do
				Isaac.Spawn(entity.Type, entity.Variant, entity.SubType, entity.Position, entity.Velocity, nil)
			end
		end
	end

	return true
end)

onActiveUse(i.FlatD6, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP
		and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, 0, entity.Position, Vector(0,0), nil)
			entity:Remove()
		end
	end

	return true
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	player = Isaac.GetPlayer(0)
	if player:HasCollectible(i.PassiveD6) then
		local entities = Isaac.GetRoomEntities()
		for i, entity in pairs(entities) do
			if entity.Type == EntityType.ENTITY_PICKUP
			and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
		end
	end
end)

--!!!!!!!!!!!!NEW CHARACTER!!!!!!!!!

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, thisEnt, damageAmt, dmgFlag, sourceEnt, dmgFrames)
	if player:GetName() == "The Bean" then
		if sourceEnt.Entity ~= nil then
			if sourceEnt.Entity.Type == EntityType.ENTITY_TEAR then
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BEAN) or player:HasCollectible(Isaac.GetItemIdByName("Mean Bean")) then
					game:Fart(thisEnt.Position, 10, nil, 1, 0)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BUTTER_BEAN) or player:HasCollectible(Isaac.GetItemIdByName("Butter Bean V2")) then
					game:ButterBeanFart(thisEnt.Position, 10, nil, true)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_MEGA_BEAN) then
					game:Fart(thisEnt.Position, 100, nil, 2, 0)
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_EXPLOSION, 1, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_KIDNEY_BEAN) then
					game:CharmFart(thisEnt.Position, 10, nil)
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_WAIT_WHAT) then
					game:ButterBeanFart(thisEnt.Position, 10, nil, true)
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_EXPLOSION, 1, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("King Bean")) then
					Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.KING_BABY, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Suicide Bean")) then
					entities = Isaac.GetRoomEntities()
					for i, entity in pairs(entities) do
						entity:Kill()
					end
					player:UseCard(Card.CARD_SUICIDE_KING)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("One True Bean")) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Batter Bean")) then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_SNACK, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Clean Bean")) then
					player:UseActiveItem(Isaac.GetItemIdByName("Clean Bean"), false, true, false, nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Fiend Bean")) then
					Isaac.Spawn(Isaac.GetEntityTypeByName("Attack Heart"), Isaac.GetEntityVariantByName("Attack Heart"), 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Beam Bean")) then
					player:UseActiveItem(Isaac.GetItemIdByName("Beam Bean"), false, true, false, nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Meme Bean")) then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_TROLL, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Beaned Bean")) then
					local num = api.Random(1,3)
					if num == 1 then
						game:Fart(thisEnt.Position, 10, nil, 1, 0)
					end
					if num == 2 then
						game:ButterBeanFart(thisEnt.Position, 10, nil, true)
					end
					if num == 3 then
						game:CharmFart(thisEnt.Position, 10, nil)
					end
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Hot Bean")) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Boil Bean")) then
					Isaac.Spawn(EntityType.ENTITY_BOIL, 0, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("The DBean")) then
					Isaac.Spawn(enemyNumbers[rng:RandomInt(#enemyNumbers + 1)], 0, 0, thisEnt.Position, Vector(0,0), nil)
					thisEnt:Remove()
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Bean Soup")) then
					player:UseActiveItem(Isaac.GetItemIdByName("Bean Soup"), false, true, false, nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Better Bean")) then
					game:Fart(player.Position, 300, player, 4, 0)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Broken Bean")) then
					player:UsePill(pi.ThreeExclamations, 0)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Bad Bean")) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Theme Bean")) then
					Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.HUSHY, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("El Bean")) then
					Isaac.Spawn(EntityType.ENTITY_PORTAL, 0, 0, thisEnt.Position, Vector(0,0), nil)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Boom Bean")) then
					Isaac.Explode(thisEnt.Position, nil, 60)
				end
				if player:HasCollectible(Isaac.GetItemIdByName("Final Bean")) then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, thisEnt.Position, Vector(0,0), nil)
				end
			end
		end
	end
end)

--!!!!!!!!!!!!PICKUPS!!!!!!!!!!!!!!!
local TextStreakScales = {
    [0] = Vector(3,0.2),	[1] = Vector(2.6,0.36),
    [2] = Vector(2.2,0.52),	[3] = Vector(1.8,0.68),
    [4] = Vector(1.4,0.84),	[5] = Vector(0.95,1.05),
    [6] = Vector(0.97,1.03),	[7] = Vector(0.98,1.02),
    [61] = Vector(0.99,1.03),	[62] = Vector(0.98,1.05),
    [63] = Vector(0.96,1.08),	[64] = Vector(0.95,1.1),
    [65] = Vector(1.36,0.92),	[66] = Vector(1.77,0.74),
    [67] = Vector(2.18,0.56),	[68] = Vector(2.59,0.38),
    [69] = Vector(3,0.2)
}

local TextStreakPositions = {
    [0] = -800,	[1] = -639,
    [2] = -450,	[3] = -250,
    [4] = -70,	[5] = 10,
    [6] = 6,	[7] = 3,
    [61] = -5,	[62] = -10,
    [63] = -15,	[64] = -20,
    [65] = 144,	[66] = 308,
    [67] = 472,	[68] = 636,
    [69] =800
}

local streakSprite = Sprite()
streakSprite:Load("gfx/streak/streak.anm2", true)
local streakFont = Font()
streakFont:Load("font/upheaval.fnt")
local streakDefaultColor = KColor(1,1,1,1,0,0,0)
local streakDefaultPos = Vector(240, 48)
local function PlayTextStreak(text, offset, color, config, renderStartPos)
    TextStreakQueue[#TextStreakQueue + 1] = {
        Text = text,
        Color = color or streakDefaultColor,
        Frame = 0,
        Width = streakFont:GetStringWidth(text) / 2,
        RenderPos = renderStartPos or streakDefaultPos,
        FontScale = Vector(1, 1),
        Offset = offset or zeroVector
    }
end

local function UpdateTextStreak()
    local streakPlaying = TextStreakQueue[1]
    if streakPlaying then
        local sprite = streakSprite

        if not streakSprite:IsPlaying("Text") then
            streakSprite:Play("Text", true)
        else
            sprite:Update()
        end

        streakPlaying.Frame = sprite:GetFrame()
        if streakPlaying.Frame >= 69 then
            streakSprite:Stop()
            table.remove(TextStreakQueue, 1)
        end

        streakPlaying.FontScale = (TextStreakScales[streakPlaying.Frame] or Vector(1, 1))
        local screenX = api.GetScreenCenterPosition().X
        streakPlaying.RenderPos.X = screenX
        streakPlaying.PositionX = (TextStreakPositions[streakPlaying.Frame] or 0) - streakPlaying.Width * streakPlaying.FontScale.X + screenX + 0.25
    end
end

local function RenderTextStreak()
    local streakPlaying = TextStreakQueue[1]
    if streakPlaying and streakSprite:IsPlaying("Text") then
        streakSprite:Render(streakPlaying.RenderPos + streakPlaying.Offset, zeroVector, zeroVector)
        streakFont:DrawStringScaled(streakPlaying.Text, streakPlaying.PositionX + streakPlaying.Offset.X, (streakPlaying.RenderPos.Y - 9) + streakPlaying.Offset.Y, streakPlaying.FontScale.X, 1, streakPlaying.Color, 0, true)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, UpdateTextStreak)
mod:AddCallback(ModCallbacks.MC_POST_RENDER, RenderTextStreak)

local jellyBeanFlavorsOld = {
    cerulean = "Blue Raspberry",
    orangespeckles = "Orange Cream",
    hotpink = "Bubblegum",
    whitebrownspeckles = "Toasted Marshmallow",
    magenta = "Strawberry",
    darkgreen = "Lime",
    burgundy = "Icky",
    inverted = "Naeb"
}

local jellyBeanFlavors = {}

for k, v in pairs(jellyBeanFlavorsOld) do
    local filename = "gfx/items/pick ups/jellybean" .. k .. ".anm2"
    Isaac.DebugString(filename)
    jellyBeanFlavors[filename] = v
end

onEntityTick(EntityType.ENTITY_PICKUP, function(p)
    p = p:ToPickup()
    p:Morph(p.Type, p.Variant, api.Random(0, 7), true)
end, ev.MoreJellyBean, 8)

onPickupPickup(ev.MoreJellyBean, function(p, player)
    local filename = p:GetSprite():GetFilename()
    local flavor = jellyBeanFlavors[filename]
    if flavor then
		print("It worked")
        Isaac.DebugString(flavor)
        PlayTextStreak(flavor)
        if flavor == "Toasted Marshmallow" then
            local entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity:IsEnemy() then
					entity:AddBurn(EntityRef(player), 3000, 40)
				end
			end
        end
		if flavor == "Icky" then
			room = game:GetRoom()
			Isaac.Spawn(EntityType.ENTITY_BRAIN, 0, 0, room:GetCenterPos(), Vector(0,0), nil)
		end
		if flavor == "Naeb" then
			room = game:GetRoom()
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLACK_HOLE, 0, room:GetCenterPos(), Vector(0,0), entity)

		end

		if player.Type == Isaac.GetPlayerTypeByName("The Bean") then
				AddBeanStats(flavor)
		end

    else
        Isaac.DebugString(filename)
    end

    if player:HasTrinket(Isaac.GetTrinketIdByName("Mystery Bean")) then
        local pool = game:GetItemPool()
        local color = pool:GetPill(p.InitSeed)
        local effect = pool:GetPillEffect(color)
        player:UsePill(effect, color)
    end

    player:AnimateHappy()
end)

replaceEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_PILL, nil, EntityType.ENTITY_PICKUP, ev.MoreJellyBean, 8, 2)
replaceEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, nil, EntityType.ENTITY_PICKUP, ev.RustedPenny, nil, 50)
replaceEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, nil, EntityType.ENTITY_PICKUP, ev.RustedKey, nil, 50)
replaceEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, 1, EntityType.ENTITY_PICKUP, ev.RustedBomb, nil, 50)
replaceEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, nil, EntityType.ENTITY_PICKUP, ev.RustedHeart, nil, 50)
replaceEntity(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, nil, EntityType.ENTITY_PICKUP, ev.RustedBattery, nil, 50)


onPickupPickup(ev.RustedPenny, function(p)
    f.RustedPenny = true
end)

onPickupPickup(ev.RustedKey, function(p)
    f.RustedKey = true
end)

onPickupPickup(ev.RustedBomb, function(p)
    f.RustedBomb = true
end)

onPickupPickup(ev.RustedHeart, function(p)
    player:AddHearts(-2)
end)

onPickupPickup(ev.RustedBattery, function(p)
    f.RustedBattery = true
end)

whenVar("RustedPenny", function()
    player:AddCoins(-99)
end)

whenVar("RustedKey", function()
    player:AddKeys(-99)
end)

whenVar("RustedBomb", function()
    player:AddBombs(-99)
end)

whenVar("RustedBattery", function()
    player:SetActiveCharge(0)
end)




--!!!!!!!!!!!!!PILLS!!!!!!!!!!!!!!!!!
onPillUse(pi.MaggyUp, function()
	player = Isaac.GetPlayer(0)
	while player:GetPlayerType() ~= PlayerType.PLAYER_MAGDALENA do
		player:AddCollectible(1, 0, false) --prevents Clicker from removing a Passive
		player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, false, false, false, false) --changes the character randomly
	end
	local heartsToAdd = 8 - player:GetMaxHearts()
	player:AddMaxHearts(heartsToAdd, false)
	player:AddHearts(8)
	player:AddBlackHearts(-24)
	player:AddSoulHearts(-24)
	player:AddBoneHearts(-24)
end)

onPillUse(pi.Deafness, function()
	f.deaf = true
end)

onPillUse(pi.HorfHorf, function()
	player = Isaac.GetPlayer(0)
	player:UsePill(PillEffect.PILLEFFECT_HORF, 0)
	f.horfActive = true
	f.horfTimer = 30
end)

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	if f.deaf then
		mus:Disable()
	end

	if f.horfActive then
		f.horfTimer = f.horfTimer - 1
		if f.horfTimer <= 0 then
			player:UsePill(PillEffect.PILLEFFECT_HORF, 1)
			f.horfActive = false
		end
	end
end)

onPillUse(pi.Megacraft, function()
	player = Isaac.GetPlayer(0)
	room = game:GetRoom()
	for i = 1, room:GetGridSize() do
		local pos = room:GetGridPosition(i)
		if pos:DistanceSquared(player.Position) < 7500 and pos:DistanceSquared(player.Position) > 1225 then
			room:SpawnGridEntity(i, api.Random(GridEntityType.GRID_ROCK, GridEntityType.GRID_ROCK_ALT), 0, room:GetSpawnSeed(), 0)
		end
	end
end)

onPillUse(pi.HourEnergy, function()
	player = Isaac.GetPlayer(0)
	player:SetActiveCharge(player:GetActiveCharge() + 1)
end)

onPillUse(pi.DamageDown, function()
	if not f.DamageDownTimesUsed then
		f.DamageDownTimesUsed = 0
	end

	f.DamageDownTimesUsed = f.DamageDownTimesUsed - 1
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player, flag)
    if not f.DamageDownTimesUsed then
        f.DamageDownTimesUsed = 0
    end

    if flag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage + f.DamageDownTimesUsed
    end
end)

onPillUse(pi.SleepParalysis, function()
	player = Isaac.GetPlayer(0)
	room = game:GetRoom()
	player:UsePill(PillEffect.PILLEFFECT_PARALYSIS, 0)
	Isaac.Spawn(enemyNumbers[rng:RandomInt(#enemyNumbers) + 1], 0, 0, room:GetCenterPos(), Vector(0,0), nil)
end)

onPillUse(pi.ThreeExclamations, function()
	player = Isaac.GetPlayer(0)
	room = game:GetRoom()
	local inv = getInventory()
	allHeld = {}
	local items = 0
	for id, numOwned in pairs (inv) do
		if numOwned > 0 then
			for i = 1, numOwned do
				allHeld[#allHeld + 1] = id
			end
		end
	end

	for i, v in pairs (allHeld) do
		player:RemoveCollectible(v)
		items = items + 1
	end

	for i=1, items do
		player:AddCollectible(rng:RandomInt(numCollectibles) + 1, 0, false)
	end
end)

onPillUse(pi.ThreeDots, function()
	local sub = rng:RandomInt(3)
	local level = game:GetLevel()
	level:SetStage(1, sub)
	game:StartStageTransition(true, 1)
end)

--!!!!!!!!!!!!!TRINKETS!!!!!!!!!!!!!!!


--!!!!!!!!!!!!!ENEMIES!!!!!!!!!!!!!!!
onEntityTick(et.Muro, function(entity)
	entity = entity:ToNPC()
	local data = entity:GetData()
	local sprite = entity:GetSprite()

	if entity.FrameCount <= 1 then
		sprite:Play("Appear", true)
		entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NOPITS
		data.hopping = false
		data.cooldown = 0
	else
		if not sprite:IsPlaying("Appear") then
            if data.cooldown > 0 then
                data.cooldown = data.cooldown - 1
            end

            if data.cooldown == 0 and data.hopping == false then
                sprite:Play("Hop", true)
                data.hopping = true
                data.targetPos = entity:GetPlayerTarget().Position
                data.targetVel = entity:GetPlayerTarget().Velocity
                local target_pos = data.targetPos
				if entity.SubType == es.Logo then
					entity.Velocity = (target_pos - entity.Position):Normalized() * -30
				else
        			entity.Velocity = (target_pos - entity.Position):Normalized() * 30
				end
			end

			if sprite:IsFinished("Hop") then
				sprite:Play("Idle", true)
				data.hopping = false
				entity.Velocity = Vector(0,0):Normalized()
			end
		end
	end
end, ev.Muro)

local boogerParams = ProjectileParams()
boogerParams.BulletFlags = ProjectileFlags.ACID_GREEN

onEntityTick(EntityType.ENTITY_MAW, function(entity)
	entity = entity:ToNPC()
	if entity.ProjectileDelay == 0 then
		tear = entity:FireProjectiles(entity.Position, (player.Position - entity.Position):Normalized() * 7, 0, boogerParams)
	end
end, ev.Nostro)

onEntityTick(EntityType.ENTITY_HORF, function(entity)
	entity = entity:ToNPC()
	local sprite = entity:GetSprite()

	if sprite:IsFinished("Appear") then
		Isaac.Explode(entity.Position, nil, 60)
	end
end, ev.Tomato)

local monstroParams = ProjectileParams()
monstroParams.ChangeVelocity = 0
monstroParams.ChangeTimeout = 15

onEntityTick(EntityType.ENTITY_MINISTRO, function(entity)
	entity = entity:ToNPC()
	local sprite = entity:GetSprite()

	if sprite:IsEventTriggered("Attack") then
		for i = 1, api.Random(32, 64) do
			monstroParams.VelocityMulti = api.Random(0, 3000) * 0.001
			entity:FireBossProjectiles(1, player.Position, 0, monstroParams)
		end
	end
end, ev.Sickstro)

replaceEntity(EntityType.ENTITY_HOPPER, nil, nil, et.Muro, ev.Muro, nil, 8)
replaceEntity(EntityType.ENTITY_HOPPER, nil, nil, et.Muro, ev.Muro, es.Logo, 8)
replaceEntity(EntityType.ENTITY_MAW, nil, nil, EntityType.ENTITY_MAW, ev.Nostro, nil, 4)
replaceEntity(EntityType.ENTITY_HORF, nil, nil, EntityType.ENTITY_HORF, ev.Tomato, nil, 4)
replaceEntity(EntityType.ENTITY_MINISTRO, nil, nil, EntityType.ENTITY_MINISTRO, ev.Sickstro, nil, 4)


--!!!!!!!!!!!!!!BOSSES!!!!!!!!!!!!!!!!
onEntityTick(et.LittlestHorn, function(entity)
	entity = entity:ToNPC()
	local data = entity:GetData()
	local sprite = entity:GetSprite()

	if entity.State == NpcState.STATE_INIT then
		sprite:Play("Appear", true)
		entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
		data.cooldown = 0
		entity.State = NpcState.STATE_MOVE
	else
		if entity.State == NpcState.STATE_MOVE then
			sprite:Play("Idle")
			angle = math.random(360) + 1
			direction = Vector.FromAngle(angle);

			if(entity.Velocity.X < 0.001 and entity.Velocity.Y < 0.001) then
				entity:AddVelocity(direction:__mul(10))
			end

			if data.cooldown <= 0 then
				entity.State = NpcState.STATE_ATTACK
				data.cooldown = 60
			end
			data.cooldown = data.cooldown - 1
		end

		if entity.State == NpcState.STATE_ATTACK then
			sprite:Play("Bomb")
			entity.Velocity = Vector(0,0)
			if sprite:IsEventTriggered("Bomb") then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_TROLL, entity.Position, Vector(0,0), nil)
			end
			if sprite:IsFinished("Bomb") then
				entity.State = NpcState.STATE_MOVE
			end
		end
	end
end, ev.LittlestHorn)

local START_FUNC = apiStart
if InfinityBossAPI then START_FUNC()
else if not __infinityBossInit then
__infinityBossInit={Mod = RegisterMod("InfinityBossAPI", 1.0)}
__infinityBossInit.Mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if not InfinityBossAPI then
		Isaac.RenderText("A MOD requires BossAPI to run, go get it on the workshop!", 100, 60, 255, 255, 255, 1)
	end
end) end
__infinityBossInit[#__infinityBossInit+1]=START_FUNC end
