-- https://www.google.com/
-- ^leaving this heere cus i keep needing to google lua stuff and i dont
-- remember the url
local mod = RegisterMod("Unpentance", 1)
local rng = RNG()

-- BIG UPS to original abortionbirth programmer for a lot of the base functions here
-- i wanted to mimic the layout of the original borty code as much as possible,
-- so i borrowed some of the borty base functions
-- big shoutouts to you genius programmer, im sorry i couldnt find your name

local i = {
	-- items
	-- the dice
	DNeg1 = "D Negative 1", -- rerolls items into black holes
	D0 = "D0", -- deletes itself from your inventory immediately
	DHalf = "D0.5", -- destroys top half of room rocks
	DOtherHalf = "D Other 0.5", --destroys bottom half of room rocks
	D2 = "D2", -- 50/50 to either win game or die
	D3 = "D3", -- rerolls items into a coin, key, and bomb
	D5 = "D5", -- rerolls bosses into enemies
	D9 = "D9", --rerolls floors
	D11 = "D11", --rerolls all items into two keys each
	D13 = "D13", -- rerolls enemies into bosses
	D14 = "D14", -- restarts room with one black fly
	D15 = "D15", -- rerolls tears into pickups
	D16 = "D16", -- rerolls fly enemies into other fly enemies
	D17 = "D17", -- rerolls enemy tears into luck upgrades
	D18 = "D18", -- rerolls pills into hush (wild woody :O)
	D19 = "D19", -- rerolls items into nothing
	D21 = "D21", -- adds +9 to one stat, adds +10 to another
	D22 = "D22", -- rerolls room doors into item pedestals
	D23 = "D23", -- rerolls enemies into ground worms
	D69 = "D69", -- rerolls entire build into bozo only
	D99 = "D99", -- rerolls pickups into golden variants
	D120 = "D120", -- rerolls familiars
	D666 = "D666", -- rerolls item pedestals into enemies
	D1337 = "D1337", -- crashes game
	D2K = "D2K", -- rerolls enemies into explosions
	DF = "DF", -- duplicates items, pickups, and monsters 5 times
	FlatD6 = "Flat D6", -- rerolls items into trinkets
	PassiveD6 = "Passive D6", -- rerolls items on room entry
	BigD6 = "The Big D6", -- spawns dice room buttons

	SlapBean = "Slap Bean", -- plays slap sfx, 1/10 chance of self-damaging
	DoubleBean = "Double Bean", -- picking up jelly beans spawns two jelly beans (doesn't work with base borty beans)
	Tomato = "Tomato", -- explodes on pickup
	NewDLC = "New DLC", -- gives full health pill
	AmongUsShirt = "Among Us Shirt", -- gives cool amogus shirt
	LilBosses = "Lil Bosses", -- spawns two bosses
	LilUltraHard = "Lil Ultra Hard", -- heart pickups no longer spawn
	MrMeaty = "Mr. Meaty", -- rerolls entire build into meat cubes only
	Tech0001 = "Tech 0.001", -- fire a tear at the closest enemy every frame
	DoubleVision = "Double Vision", -- entering a room duplicates items, pickups, and monsters
	KeepersKey = "Keeper's Key", -- does not work :(
	GreedsKidney = "Greed's Kidney", -- turns you into keeper
	ToggleWings = "Toggle Wings", -- gives you flight, takes away flight if you can already fly
	LogosHat = "Logo's Hat", -- all enemies in L shaped rooms would be replaced with logos
	Tax = "Tax", -- all shop items cost an extra penny (price increases on shop entry oops)
	ExtraSalt = "Extra Salt", -- tears up
	Burger = "Burger With No Honey Mustard", -- hp up
	LeakyBean = "Leaky Bean", -- spawns creep ring around player
	TimeBomb = "Ticking Time Bomb", -- when game timer hits 30 minutes, player explodes every 5 seconds
	Cyberpunk = "Cyberpunk 2077", -- spawns bug enemy every 5 seconds
	PaxDemo = "PAX Demo", -- when game timer hits 10 minutes, player becomes the lost
	Chaos2 = "Chaos 2", -- gives chaos, breakfast rerolls into brimstone
	MagnifyingGlass = "Magnifying Glass", -- all enemies are giant champions
	DeliriousVeggie = "Delirious Vegetable Peeler", -- use on delirium = ???

	EnviousBum = "Envious Bum", -- picks up items, drops other items
	PridefulBum = "Prideful Bum", -- picks up items, drops prideful bum
	SlothlyBum = "Slothly Bum", -- spreads green creep
	WrathfulBum = "Wrathful Bum", -- picks up bombs, drops troll bombs
	LustfulBum = "Lustful Bum", -- picks up hearts, drop hearts
	GluttonousBum = "Gluttonous Bum", -- picks up food items, drops red creep
	GreedyBum = "Greedy Bum", -- picks up pennies, drops nothing
	LilKamikaze = "Lil Kamikaze", -- explodes every 4 rooms
	LilForgotten = "Lil Forgotten", -- drops moms foot every 6 rooms
	LilD10 = "Lil D10" -- rerolls enemies every 4 rooms
}

local c = {
	-- costumes
	PassiveD6 = "passived6",
	DoubleBean = "doublebean",
	Tomato = "tomato",
	NewDLC = "newdlc",
	AmongUsShirt = "amongusshirt",
	LilUltraHard = "lilultrahard",
	MrMeaty = "mrmeaty",
	Tech0001 = "tech0001",
	DoubleVision = "doublevision",
	LogosHat = "logoshat",
	Tax = "tax",
	ExtraSalt = "extrasalt",
	Burger = "burger",
	TimeBomb = "timebomb",
	Cyberpunk = "cyberpunk",
	Chaos2 = "chaos2",
	MagnifyingGlass = "magnifyingglass"
}

local pi = {
	-- pills
	MaggyUp = "Maggy Up", -- turns player into maggy
	Deafness = "Deafness", -- mutes music
	HorfHorf = "Horf...Horf!", -- uses horf twice
	Megacraft = "Megacraft", -- spawns ring of rocks around player
	HourEnergy = "1 Hour Energy!", -- adds 1 charge to active item
	DamageDown = "Damage Down", -- damage downgrade
	SleepParalysis = "Sleep Paralysis", -- paralysis, spawns enemy
	ThreeExclamations = "!!!", -- rerolls run
	ThreeDots = "..." -- sends you back to basement 1
}

local et = {
	-- enemies
	Muro = "Muro",
	Amogus = "Amogus",
	-- bosses
	LittlestHorn = "Littlest Horn",
	Imposter = "Imposter",
	Vent = "Vent",
	ImposterMissle = "Imposter Missle",
	SkinlessDelirium = "Skinless Delirium"
}

local ev = {
	-- enemies
	Muro = "Muro",
	Nostro = "Nostro",
	Tomato = "Tomato",
	Sickstro = "Sickstro",
	Amogus = "Amogus",
	-- bosses
	LittlestHorn = "Littlest Horn",
	Imposter = "Imposter",
	Vent = "Vent",
	ImposterMissle = "Imposter Missle",
	Monstro3 = "Monstro III",
	SkinlessDelirium = "Skinless Delirium",
	-- pickups
	MoreJellyBean = "Jelly Bean Inverted",
	RustedPenny = "Rusted Penny",
	RustedKey = "Rusted Key",
	RustedBomb = "Rusted Bomb",
	RustedHeart = "Rusted Heart",
	RustedBattery = "Rusted Battery",
	-- familiars
	EnviousBum = "Envious Bum",
	PridefulBum = "Prideful Bum",
	SlothlyBum = "Slothly Bum",
	WrathfulBum = "Wrathful Bum",
	LustfulBum = "Lustful Bum",
	GluttonousBum = "Gluttonous Bum",
	GreedyBum = "Greedy Bum",
	LilKamikaze = "Lil Kamikaze",
	LilForgotten = "Lil Forgotten",
	LilD10 = "Lil D10"
}

local es = {
	Logo = 1,
	DeliriumImposter = 1,
	DeliriumLittlestHorn = 1,
	DeliriumMonstro3 = 3,
	DeliriumNerve3 = 1,
	DeliriumMediumHorn = 2424,
	DeliriumSecretBoss = 1,
	DeliriumPrecursor = 874,
	DeliriumUltraEnvy = 1,
	DeliriumSanta = 1,
	DeliriumMegaUltraEnvy = 2424
}

local f = {
	deaf = false,
	lost = false,
	sfxCountdown = 0,
	noCountdown = 0
}

local t = {
	-- twinkets
	Streamdeck = "Streamdeck", -- plays random sfx depending on player velocity
	Diarrhea = "Diarrhea", -- turns poops into brown creep
	BigNo = "Big NO!", -- if player is holding an active item, take damage every 5 seconds
	IceCube = "Ice Cube", -- adds slippery creep to all enemies
	reallylazyworm = "REALLY Lazy Worm" -- not implemented...secret.....
}

local s = {
	-- sounds
	TwentyOne = "Twenty One",
	Yahoo = "Yahoo",
	Slap = "Slap",
	Vent = "Vent",
	RoleReveal = "Role Reveal",
	Gunshot = "Gunshot",
	Death = "Death",
	Victory = "Victory",
	RustedPenny = "Rusted Penny",
	RustedKey = "Rusted Key",
	RustedBomb = "Rusted Bomb",
	RustedHeart = "Rusted Heart",
	RustedBattery = "Rusted Battery"
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

local saltStats = {
	MaxFireDelay = -2,
}

local amogusList = {}
local vents = {}

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
	295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,
	Isaac.GetEntityTypeByName("Muro")
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
	Isaac.GetEntityTypeByName("Abortionbirth SECRET BOSS"), Isaac.GetEntityTypeByName("Littlest Horn"),
	Isaac.GetEntityTypeByName("Monstro III"), Isaac.GetEntityTypeByName("Imposter"),
	Isaac.GetEntityTypeByName("Skinless Delirium")
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
	Isaac.GetItemIdByName("The Ghost"),
	Isaac.GetItemIdByName("Envious Bum"), Isaac.GetItemIdByName("Prideful Bum"), Isaac.GetItemIdByName("Slothly Bum"),
	Isaac.GetItemIdByName("Wrathful Bum"), Isaac.GetItemIdByName("Lustful Bum"), Isaac.GetItemIdByName("Gluttonous Bum"),
	Isaac.GetItemIdByName("Greedy Bum"),  Isaac.GetItemIdByName("Lil D10"), Isaac.GetItemIdByName("Lil Forgotten"),
	Isaac.GetItemIdByName("Lil Kamikaze"),
}

local championable = {
	10,11,12,14,15,16,
	21,22,23,24,25,26,27,
	29,30,31,32,
	34,
	38,39,40,41,
	53,54,55,56,57,58,59,60,61,
	86,87,88,91,
	204,205,206,207,208,209,210,
	220,237,
	246,247,248,252,254,259,
	278,279,280,282,283,284,290,
	298,299,300,301,303,304,305,307,308,309,310,
	Isaac.GetEntityTypeByName("Muro")
}

local bugs = {
    EntityType.ENTITY_FLY,
    EntityType.ENTITY_FLY_L2,
    EntityType.ENTITY_BIGSPIDER,
    EntityType.ENTITY_SPIDER,
    EntityType.ENTITY_SPIDER_L2,
    EntityType.ENTITY_TICKING_SPIDER,
    EntityType.ENTITY_RING_OF_FLIES,
    EntityType.ENTITY_POOTER,
    EntityType.ENTITY_DART_FLY,
    EntityType.ENTITY_DADDYLONGLEGS,
    EntityType.ENTITY_SWARM,
    EntityType.ENTITY_DUKE,
    EntityType.ENTITY_DUKIE,
    EntityType.ENTITY_BABY_LONG_LEGS,
    EntityType.ENTITY_WALL_CREEP,
    EntityType.ENTITY_BLIND_CREEP,
    EntityType.ENTITY_RAGE_CREEP,
    EntityType.ENTITY_THE_THING,
    EntityType.ENTITY_ETERNALFLY,
    EntityType.ENTITY_ATTACKFLY,
    EntityType.ENTITY_BLISTER,
    EntityType.ENTITY_BOOMFLY,
    EntityType.ENTITY_NEST,
    EntityType.ENTITY_CRAZY_LONG_LEGS,
    EntityType.ENTITY_FULL_FLY,
    EntityType.ENTITY_HUSH_FLY,
    EntityType.ENTITY_MOTER,
    EntityType.ENTITY_WIDOW,
    [tostring(EntityType.ENTITY_BOIL)] = {2},
    [tostring(EntityType.ENTITY_PICKUP)] = {
        [tostring(PickupVariant.PICKUP_COLLECTIBLE)] = {
            CollectibleType.COLLECTIBLE_LOST_FLY,
            CollectibleType.COLLECTIBLE_PAPA_FLY,
            CollectibleType.COLLECTIBLE_SMART_FLY,
            CollectibleType.COLLECTIBLE_ANGRY_FLY,
            CollectibleType.COLLECTIBLE_JUICY_SACK,
            CollectibleType.COLLECTIBLE_FRIEND_ZONE,
            CollectibleType.COLLECTIBLE_SPIDER_MOD,
            CollectibleType.COLLECTIBLE_SPIDER_BITE,
            CollectibleType.COLLECTIBLE_SPIDER_BUTT,
            CollectibleType.COLLECTIBLE_SPIDERBABY,
            CollectibleType.COLLECTIBLE_BBF,
            CollectibleType.COLLECTIBLE_BIG_FAN,
            CollectibleType.COLLECTIBLE_SKATOLE,
            CollectibleType.COLLECTIBLE_HALO_OF_FLIES,
            CollectibleType.COLLECTIBLE_FOREVER_ALONE,
            CollectibleType.COLLECTIBLE_BLUEBABYS_ONLY_FRIEND,
            CollectibleType.COLLECTIBLE_SISSY_LONGLEGS,
            CollectibleType.COLLECTIBLE_HIVE_MIND,
            CollectibleType.COLLECTIBLE_DADDY_LONGLEGS,
            CollectibleType.COLLECTIBLE_MUTANT_SPIDER,
            CollectibleType.COLLECTIBLE_INFESTATION_2,
            CollectibleType.COLLECTIBLE_MULLIGAN,
            CollectibleType.COLLECTIBLE_DISTANT_ADMIRATION,
            CollectibleType.COLLECTIBLE_PARASITOID
        }
    },
    [tostring(EntityType.ENTITY_FAMILIAR)] = {
        FamiliarVariant.BLUE_FLY,
        FamiliarVariant.BLUE_SPIDER
    }
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
        elseif contentType == "S" then
     	    id = Isaac.GetSoundIdByName(v)
        elseif contentType == "P" then
         	id = Isaac.GetPillEffectByName(v)
		elseif contentType == "C" then
			id = Isaac.GetCostumeIdByPath("gfx/characters/costumes/".. v ..".anm2")
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
s = convert(s, "S")
pi = convert(pi, "P")
c = convert(c, "C")

local function apiStart()
    api = InfinityBossAPI
    api.AddBossToPool("gfx/bossui/portrait_littlesthorn.png", "gfx/bossui/bossname_littlesthorn.png", et.LittlestHorn, ev.LittlestHorn, 0, LevelStage.STAGE1_1, nil, 50, nil, nil, nil)
	api.AddBossToPool("gfx/bossui/portrait_littlesthorn.png", "gfx/bossui/bossname_littlesthorn.png", et.LittlestHorn, ev.LittlestHorn, 0, LevelStage.STAGE1_2, nil, 50, nil, nil, nil)
	api.AddBossToPool("gfx/bossui/portrait_imposter.png", "gfx/bossui/bossname_imposter.png", et.Imposter, ev.Imposter, 0, LevelStage.STAGE2_1, nil, 50, nil, nil, nil)
	api.AddBossToPool("gfx/bossui/portrait_imposter.png", "gfx/bossui/bossname_imposter.png", et.Imposter, ev.Imposter, 0, LevelStage.STAGE2_2, nil, 50, nil, nil, nil)
	api.AddBossToPool("gfx/bossui/portrait_monstro3.png", "gfx/bossui/bossname_monstro3.png", EntityType.ENTITY_MONSTRO, ev.Monstro3, 0, LevelStage.STAGE4_1, nil, 50, nil, nil, nil)

end

local stupidSimpleFamiliars = {
    [i.EnviousBum] = {
        1,
        ev.EnviousBum
    },
	[i.PridefulBum] = {
        1,
        ev.PridefulBum
    },
	[i.SlothlyBum] = {
        1,
        ev.SlothlyBum
    },
	[i.WrathfulBum] = {
        1,
        ev.WrathfulBum
    },
	[i.LustfulBum] = {
        1,
        ev.LustfulBum
    },
	[i.GluttonousBum] = {
        1,
        ev.GluttonousBum
    },
	[i.GreedyBum] = {
        1,
        ev.GreedyBum
    },
	[i.LilKamikaze] = {
        1,
        ev.LilKamikaze
    },
	[i.LilForgotten] = {
        1,
        ev.LilForgotten
    },
	[i.LilD10] = {
        1,
        ev.LilD10
    },

}

local function fancyNewCheckFamiliar(variant, subtype, count, p)
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, variant or -1, subtype or -1, false, false)
    if #familiars < count then
        for i = 1, count - #familiars do
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, variant or 0, subtype or 0, player.Position, zeroVector, player)
        end
    elseif #familiars > count then
        local numRemoved = #familiars - count
        for _, fam in ipairs(familiars) do
            fam:Remove()
            numRemoved = numRemoved - 1

            if numRemoved <= 0 then
                break
            end
        end
    end
end

local familiarRNG = RNG()

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

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, p, flag)
    if flag == CacheFlag.CACHE_FAMILIARS then
        local boxOfFriendsTimesUsed = p:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS) + 1
        for id, familiarData in pairs(stupidSimpleFamiliars) do
            local count = (familiarData[1] * p:GetCollectibleNum(id)) * boxOfFriendsTimesUsed
            fancyNewCheckFamiliar(familiarData[2], familiarData[3], count, p)
            --p:CheckFamiliar(familiarData[2], count, familiarRNG)
        end
    end
end)

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

local function onFamiliarTick(variant, fn, subtype)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, fam)
        if not subtype or fam.SubType == subtype then
            fn(fam)
        end
    end, variant)
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

local function isin(tbl, thing, fn)
    for _, obj in (fn or ipairs)(tbl) do
        if obj == thing then
            return true
        end
    end
end

local function getNearestEnemy(pos)
    local dist
    local near
	local enemies = Isaac.GetRoomEntities()
    for _, ent in ipairs(enemies) do
		if ent:IsVulnerableEnemy() and ent:IsActiveEnemy() and not ent:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
	        local distance = ent.Position:Distance(pos or player.Position)
	        if not dist or distance < dist then
	            dist = distance
	            near = ent
	        end
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

local function GetAllEntries(tbl) -- WEIRDO TABLE SYSTEM
    local ret = {}

    for _, entityType in ipairs(tbl) do -- LAYER ONE, NUMBER INDEXES ARE TYPES
        ret[#ret + 1] = {entityType}
    end

    for entityTypeKey, entityVariantList in pairs(tbl) do
        if type(entityTypeKey) == "string" then
            local entityType = tonumber(entityTypeKey)
            for _, entityVariant in ipairs(entityVariantList) do
                ret[#ret + 1] = {entityType, entityVariant}
            end

            for entityVariantKey, entitySubtypeList in pairs(entityVariantList) do
                if type(entityVariantKey) == "string" then
                    local entityVariant = tonumber(entityVariantKey)
                    for _, entitySubtype in ipairs(entitySubtypeList) do
                        ret[#ret + 1] = {entityType, entityVariant, entitySubtype}
                    end
                end
            end
        end
    end

    return ret
end

local function mergeTable(tbl, tbl2, ip)
    local ret = {}

    if not ip then
        for k, v in pairs(tbl) do
            ret[k] = v
        end

        for k, v in pairs(tbl2) do
            ret[k] = v
        end
    else
        for _, v in ipairs(tbl) do
            ret[#ret + 1] = v
        end

        for _, v in ipairs(tbl2) do
            ret[#ret + 1] = v
        end
    end

    return ret
end

local function GetEntityList(tbl)
    local ret = {}

    local allEntries = GetAllEntries(tbl)
    for _, entityConfig in ipairs(allEntries) do
        local entList = Isaac.FindByType(entityConfig[1] or -1, entityConfig[2] or -1, entityConfig[3] or -1, false, false)
        ret = mergeTable(ret, entList, true)
    end

    return ret
end

local function Nearest(pos, entlist)
    local nearestDist
    local nearestEnt
    for _, ent in ipairs(entlist) do
        local dist = pos:DistanceSquared(ent.Position)
        if not nearestDist or dist < nearestDist then
            nearestDist = dist
            nearestEnt = ent
        end
    end

    return nearestEnt
end


local function bumAI(variant, thingsToCollect, rewards, numNeededPerReward, thingCheck)
    onFamiliarTick(variant, function(fam)
        local data = fam:GetData()
        local collect = GetEntityList(thingsToCollect)
        local validEnts = {}

        if #collect > 0 then
            for _, ent in ipairs(collect) do
                if not ent:GetSprite():IsPlaying("Collect") then
                    if not thingCheck then
                        validEnts[#validEnts + 1] = ent
                    elseif thingCheck(ent) then
                        validEnts[#validEnts + 1] = ent
                    end
                end
            end
        end

        if not fam:GetSprite():IsPlaying("Spawn") and not fam:GetSprite():IsFinished("Spawn") and not fam:GetSprite():IsPlaying("PreSpawn") and not fam:GetSprite():IsFinished("PreSpawn") then
            fam:GetSprite():Play("FloatDown", true)
        end

        if #validEnts > 0 and not fam:GetSprite():IsPlaying("Spawn") and not fam:GetSprite():IsFinished("Spawn") and not fam:GetSprite():IsPlaying("PreSpawn") and not fam:GetSprite():IsFinished("PreSpawn") then
            local nearest = Nearest(fam.Position, validEnts)
            local dir = (nearest.Position - fam.Position):Normalized()
            fam.Velocity = dir * 2
            if nearest:GetData().Collected and not nearest:GetSprite():IsPlaying("Collect") then
                nearest:Remove()
            end

            if not nearest:GetSprite():IsPlaying("Collect") and not nearest:GetData().Collected and entsCollide(fam, nearest) then
                if not data.Collect then
                    data.Collect = 1
                else
                    data.Collect = data.Collect + 1
                end

                if data.Collect > numNeededPerReward then
                    fam:GetSprite():Play("PreSpawn", true)
                end

                nearest:GetSprite():Play("Collect", true)
                nearest:GetData().Collected = true
            end
        else
            if fam:GetSprite():IsFinished("PreSpawn") then
                fam:GetSprite():Play("Spawn", true)
            end

            if fam:GetSprite():IsFinished("Spawn") then
                while data.Collect > numNeededPerReward do
                    data.Collect = data.Collect - numNeededPerReward
                    local possibleRewards = GetAllEntries(rewards)
                    local reward = possibleRewards[api.Random(1, #possibleRewards)]
                    Isaac.Spawn(reward[1], reward[2] or 0, reward[3] or 0, room:FindFreePickupSpawnPosition(fam.Position, 0, true), RandomVector() * 4, fam)
                end

                fam:GetSprite():Play("FloatDown", true)
            end

            fam:FollowParent()
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
	local monster = api.Random(403) + 10
	if BossOrMonster(monster, false) then
		return monster
	else
		return GenerateRandomEnemy()
	end
end

local function GenerateRandomBoss()
	local boss = api.Random(403) + 10
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
	if f.taxAdded then
		f.taxAdded = false
	end
end)


mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	player = Isaac.GetPlayer(0)
    invStuff = {}
	d17Stats.Luck = 0
	d21Info.used = false
	f.deaf = false
	f.DamageDownTimesUsed = 0
	f.taxAdded = false
	f.lost = false
	f.sfxCountdown = 0
	f.noCountdown = 0
	f.deliCountdown = 60
	f.attackCountdown = 30
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
	local flip = api.Random(0,1)
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
	local floor = api.Random(1, 12)
	local sub = api.Random(2)
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
				Isaac.Spawn(flyNumbers[api.Random(1, #flyNumbers)], 0, 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
		end
	end

	return true
end)

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
	local flag1 = d21Flags[api.Random(3)+1]
	local flag2 = d21Flags[api.Random(3)+1]
	while flag1 == flag2 do
		flag2 = d21Flags[api.Random(3)+1]
	end
	local stat1 = FlagToStat(flag1)
	local stat2 = FlagToStat(flag2)
	d21Stats[stat1] = 9
	d21Stats[stat2] = 10
	player:AddCacheFlags(flag1 | flag2)
	player:EvaluateItems()

	player:RemoveCollectible(i.D21)
	sfx:Play(s.TwentyOne, 1, 0, false, 1)
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
	player:RemoveCollectible(i.D22)

	return true
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
				newFamiliar = familiarNumbers[api.Random(1,#familiarNumbers)]
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
			newEnemy = enemyNumbers[api.Random(1, #enemyNumbers)]
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
	local entities = Isaac.GetRoomEntities()
	if player:HasCollectible(i.PassiveD6) then
		for i, entity in pairs(entities) do
			if entity.Type == EntityType.ENTITY_PICKUP
			and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, entity.Position, Vector(0,0), nil)
				entity:Remove()
			end
		end
	end
	if player:HasCollectible(i.DoubleVision) then
		for i, entity in pairs(entities) do
			if entity.Type == EntityType.ENTITY_PICKUP
			or entity:IsActiveEnemy() then
				Isaac.Spawn(entity.Type, entity.Variant or 0, entity.SubType or 0, room:FindFreePickupSpawnPosition(entity.Position, 0, true) or Vector(0,0), entity.Vector or Vector(0,0), nil)
			end
		end
	end
	if player:HasCollectible(i.LogosHat) then
		if room:IsLShapedRoom() then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity:IsActiveEnemy() then
					Isaac.Spawn(et.Muro, ev.Muro, es.Logo, entity.Position, entity.Velocity, nil)
					entity:Remove()
				end
			end
		end
	end
end)

onItemPickup(i.PassiveD6, function()
	player:AddNullCostume(c.PassiveD6)
end)

onItemPickup(i.LogosHat, function()
	player:AddNullCostume(c.LogosHat)
end)

onItemPickup(i.DoubleVision, function()
	player:AddNullCostume(c.DoubleVision)
end)

onActiveUse(i.SlapBean, function()
	sfx:Play(s.Slap, 1, 0, false, 1)
	local num = api.Random(1,10)
	if num == 10 then
		player:TakeDamage(1, 0, EntityRef(player), 0)
	end

	return true
end)

onActiveUse(i.BigD6, function()
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DICE_FLOOR, api.Random(1,6), room:GetCenterPos(), Vector(0,0), nil)

	return true
end)

onItemPickup(i.DoubleBean, function()
	player:AddNullCostume(c.DoubleBean)
end)

onItemPickup(i.Tomato, function()
	player:AddNullCostume(c.Tomato)
	Isaac.Explode(player.Position, nil, 60)
end)

onItemPickup(i.NewDLC, function()
	player:AddNullCostume(c.NewDLC)
	player:AddPill(Isaac.AddPillEffectToPool(PillEffect.PILLEFFECT_FULL_HEALTH))
end)

onItemPickup(i.AmongUsShirt, function()
	player:AddNullCostume(c.AmongUsShirt)
end)

onActiveUse(i.LilBosses, function()
	Isaac.Spawn(bossNumbers[api.Random(#bossNumbers+1)], 0, 0, room:GetCenterPos() + Vector(200,0), Vector(0,0), nil)
	Isaac.Spawn(bossNumbers[api.Random(#bossNumbers+1)], 0, 0, room:GetCenterPos() - Vector(200,0), Vector(0,0), nil)

	return true
end)

onItemPickup(i.LilUltraHard, function()
	player:AddNullCostume(c.LilUltraHard)
end)

onPassiveTick(i.LilUltraHard, function()
	local entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP
		and entity.Variant == PickupVariant.PICKUP_HEART or entity.Variant == ev.RustedHeart then
			entity:Remove()
		end
	end
end)

onItemPickup(i.MrMeaty, function()
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
		player:AddCollectible(CollectibleType.COLLECTIBLE_CUBE_OF_MEAT, 0, false)
	end

	player:AddNullCostume(c.MrMeaty)
end)

onItemPickup(i.Tech0001, function()
	player:AddNullCostume(c.Tech0001)
end)

onPassiveTick(i.Tech0001, function()
	local near = getNearestEnemy()
	if near ~= nil then
		player:FireTear(player.Position, (near.Position - player.Position):Normalized() * 10, false, true, false)
	end
end)

onItemPickup(i.Tax, function()
	player:AddNullCostume(c.Tax)
end)

onEntityTick(EntityType.ENTITY_PICKUP, function(ent)
	if player:HasCollectible(i.Tax) then
		ent = ent:ToPickup()
		data = ent:GetData()
		if data.taxAdded == nil then
			data.taxAdded = false
		    if ent:IsShopItem() and not data.taxAdded then
		        ent.Price = ent.Price + 1
		        ent.AutoUpdatePrice = false
				data.taxAdded = true
		    end
		end
	end
end, nil, nil)

-- DOESN'T WORK: crossing between normal and greed mode appears to crash the game, maybe someday :O
-- onActiveUse(i.KeepersKey, function()
-- 	level = game:GetLevel()
-- 	if level:GetStageType() ==  StageType.STAGETYPE_GREEDMODE then
-- 		level:SetStage(level:GetStage(), api.Random(2))
-- 	else
-- 		level:SetStage(level:GetStage(), StageType.STAGETYPE_GREEDMODE)
-- 	end
-- 	game:StartStageTransition(true, 1)
-- end)

onItemPickup(i.GreedsKidney, function()
	player = Isaac.GetPlayer(0)
	while player:GetPlayerType() ~= PlayerType.PLAYER_KEEPER do
		player:AddCollectible(1, 0, false) --prevents Clicker from removing a Passive
		player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, false, false, false, false) --changes the character randomly
	end
end)

onItemPickup(i.ToggleWings, function()
	f.toggleWings = true
	player:AddCacheFlags(CacheFlag.CACHE_FLYING)
	player:EvaluateItems()
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player, flag)
    if flag == CacheFlag.CACHE_FLYING then
        if f.toggleWings then
			player.CanFly = not player.CanFly
			f.toggleWings = false
		end
    end
end)

onItemPickup(i.ExtraSalt, function()
	player:AddNullCostume(c.ExtraSalt)
	f.SaltApplied = false
	player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
	player:EvaluateItems()
end)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player, flag)
	if flag == CacheFlag.CACHE_FIREDELAY then
		if not f.SaltApplied then
			player.MaxFireDelay = player.MaxFireDelay - 1
			f.SaltApplied = true
		end
	end
end)

onItemPickup(i.Burger, function()
	player:AddNullCostume(c.Burger)
end)

local enviousBumCollects = {
    [tostring(EntityType.ENTITY_PICKUP)] = {
        PickupVariant.PICKUP_COLLECTIBLE
    }
}

local enviousBumRewards = {
    [tostring(EntityType.ENTITY_PICKUP)] = {
        PickupVariant.PICKUP_COLLECTIBLE
    }
}

bumAI(ev.EnviousBum, enviousBumCollects, enviousBumRewards, 1)

local pridefulBumCollects = {
    [tostring(EntityType.ENTITY_PICKUP)] = {
        PickupVariant.PICKUP_COLLECTIBLE
    }
}

local pridefulBumRewards = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
        [tostring(PickupVariant.PICKUP_COLLECTIBLE)] = {
            i.PridefulBum
        }
    }
}

bumAI(ev.PridefulBum, pridefulBumCollects, pridefulBumRewards, 1)

local slothlyBumCollects = {

}

local slothlyBumRewards = {

}

bumAI(ev.SlothlyBum, slothlyBumCollects, slothlyBumRewards, 1)

onFamiliarTick(ev.SlothlyBum, function(fam)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, fam.Position, Vector(0,0), nil)
end)

local wrathfulBumCollects = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
		[tostring(PickupVariant.PICKUP_BOMB)] = {
			BombSubType.BOMB_NORMAL,
			BombSubType.BOMB_DOUBLEPACK,
			BombSubType.BOMB_GOLDEN,
			ev.RustedBomb
		}
	}
}

local wrathfulBumRewards = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
		[tostring(PickupVariant.PICKUP_BOMB)] = {
			BombSubType.BOMB_TROLL,
			BombSubType.BOMB_SUPERTROLL,
		}
	}
}

bumAI(ev.WrathfulBum, wrathfulBumCollects, wrathfulBumRewards, 1)

local lustfulBumCollects = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
		[tostring(PickupVariant.PICKUP_HEART)] = {
			HeartSubType.HEART_FULL,
			HeartSubType.HEART_HALF,
			HeartSubType.HEART_DOUBLEPACK,
			HeartSubType.HEART_SCARED
		}
	}
}

local lustfulBumRewards = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
		[tostring(PickupVariant.PICKUP_HEART)] = {
			HeartSubType.HEART_FULL,
			HeartSubType.HEART_HALF,
			HeartSubType.HEART_DOUBLEPACK,
			HeartSubType.HEART_SCARED
		}
	}
}

bumAI(ev.LustfulBum, lustfulBumCollects, lustfulBumRewards, 1)

local gluttonousBumCollects = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
		[tostring(PickupVariant.PICKUP_COLLECTIBLE)] = {
			CollectibleType.COLLECTIBLE_LUNCH,
		    CollectibleType.COLLECTIBLE_BREAKFAST,
		    CollectibleType.COLLECTIBLE_MOLDY_BREAD,
		    CollectibleType.COLLECTIBLE_DINNER,
		    CollectibleType.COLLECTIBLE_DESSERT,
		    CollectibleType.COLLECTIBLE_SNACK,
		    CollectibleType.COLLECTIBLE_FRUIT_CAKE,
		    CollectibleType.COLLECTIBLE_RAW_LIVER,
		    CollectibleType.COLLECTIBLE_ROTTEN_MEAT,
		    CollectibleType.COLLECTIBLE_BLACK_LOTUS,
			Isaac.GetItemIdByName("Oatmeal"),
			Isaac.GetItemIdByName("Desert 2"),
			Isaac.GetItemIdByName("Chicken n' Chips"),
			i.Burger
		}
	}
}

local gluttonousBumRewards = {
	[tostring(EntityType.ENTITY_EFFECT)] = {
		EffectVariant.PLAYER_CREEP_RED
	}
}

bumAI(ev.GluttonousBum, gluttonousBumCollects, gluttonousBumRewards, 1)

local greedyBumCollects = {
	[tostring(EntityType.ENTITY_PICKUP)] = {
		[tostring(PickupVariant.PICKUP_COIN)] = {
			CoinSubType.COIN_PENNY,
			CoinSubType.COIN_NICKEL,
			CoinSubType.COIN_DIME,
			CoinSubType.COIN_DOUBLEPACK,
			CoinSubType.COIN_LUCKYPENNY,
			CoinSubType.COIN_STICKYNICKEL,
			Isaac.GetEntityVariantByName("Gold Penny"),
			ev.RustedPenny
		}
	}
}

local greedyBumRewards = {

}

bumAI(ev.GreedyBum, greedyBumCollects, greedyBumRewards, 1)

onFamiliarTick(ev.LilKamikaze, function(fam)
    local data = fam:GetData()
    local sprite = fam:GetSprite()

    if not sprite:IsPlaying("Spawn") and not sprite:IsPlaying("FloatDown") then
        sprite:Play("FloatDown", true)
    end

    if room:IsFirstVisit() and room:GetFrameCount() == 1 then
        if not data.Rooms then
            data.Rooms = 0
        end
        data.Rooms = data.Rooms + 1
        if data.Rooms >= 4 then
            Isaac.Explode(fam.Position, nil, 60)
            sprite:Play("Spawn", true)
            data.Rooms = 0
        end
    end

    fam:FollowParent()
end)

onFamiliarTick(ev.LilForgotten, function(fam)
    local data = fam:GetData()
    local sprite = fam:GetSprite()

    if not sprite:IsPlaying("Spawn") and not sprite:IsPlaying("FloatDown") then
        sprite:Play("FloatDown", true)
    end

    if room:IsFirstVisit() and room:GetFrameCount() == 1 then
        if not data.Rooms then
            data.Rooms = 0
        end
        data.Rooms = data.Rooms + 1
        if data.Rooms >= 6 then
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.MOM_FOOT_STOMP, 0, fam.Position, Vector(0,0), nil)
            sprite:Play("Spawn", true)
            data.Rooms = 0
        end
    end

    fam:FollowParent()
end)

onFamiliarTick(ev.LilD10, function(fam)
    local data = fam:GetData()
    local sprite = fam:GetSprite()

    if not sprite:IsPlaying("Spawn") and not sprite:IsPlaying("FloatDown") then
        sprite:Play("FloatDown", true)
    end

    if room:IsFirstVisit() and room:GetFrameCount() == 1 then
        if not data.Rooms then
            data.Rooms = 0
        end
        data.Rooms = data.Rooms + 1
        if data.Rooms >= 4 then
            player:UseActiveItem(CollectibleType.COLLECTIBLE_D10, false, false, false, false)
			sprite:Play("Spawn", true)
            data.Rooms = 0
        end
    end

    fam:FollowParent()
end)

local customFamiliars = {
    ev.EnviousBum,
	ev.PridefulBum,
	ev.SlothlyBum,
	ev.WrathfulBum,
	ev.LustfulBum,
	ev.GluttonousBum,
	ev.GreedyBum,
	ev.LilKamikaze,
	ev.LilForgotten,
	ev.LilD10
}

mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, function(_, fam)
    if isin(customFamiliars, fam.Variant) then
        fam:AddToFollowers()
    end
end)

onActiveUse(i.LeakyBean, function()
	local interval = 39
	sfx:Play(SoundEffect.SOUND_SMB_LARGE_CHEWS_4, 1, 0, false, 1)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(interval,0), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(interval,interval), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(0,interval), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(-interval,interval), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(-interval,0), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(-interval,-interval), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(0,-interval), Vector(0,0), nil)
	Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position + Vector(interval,-interval), Vector(0,0), nil)

	return true
end)

onItemPickup(i.TimeBomb, function()
	player:AddNullCostume(c.TimeBomb)
end)

onPassiveTick(i.TimeBomb, function()
	if game.TimeCounter >= 54000 then
		if game.TimeCounter % 150 == 0 then
			Isaac.Explode(player.Position, nil, 40)
		end
	end
end)

onItemPickup(i.Cyberpunk, function()
	player:AddNullCostume(c.Cyberpunk)
end)

onPassiveTick(i.Cyberpunk, function()
	if game.TimeCounter % 150 == 0 then
		Isaac.Spawn(bugs[api.Random(#bugs)+1], 0, 0, room:GetCenterPos(), Vector(0,0), nil)
	end
end)

onPassiveTick(i.PaxDemo, function()
	if game.TimeCounter % 18000 == 0 and not lost then
		while player:GetPlayerType() ~= PlayerType.PLAYER_THELOST do
			player:AddCollectible(1, 0, false) --prevents Clicker from removing a Passive
			player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, false, false, false, false) --changes the character randomly
		end
		lost = true
	end
end)

onItemPickup(i.Chaos2, function()
	player:AddNullCostume(c.Chaos2)
	player:AddCollectible(CollectibleType.COLLECTIBLE_CHAOS, 0, false)
end)

onPassiveTick(i.Chaos2, function()
	entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_PICKUP
		and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE
		and entity.SubType == CollectibleType.COLLECTIBLE_BREAKFAST then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BRIMSTONE, entity.Position, Vector(0,0), nil)
			entity:Remove()
		end
	end
end)

onItemPickup(i.MagnifyingGlass, function()
	player:AddNullCostume(c.MagnifyingGlass)
end)

onPassiveTick(i.MagnifyingGlass, function()
	entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		for i, champion in pairs(championable) do
			if entity.Type == champion then
				entity:ToNPC():Morph(entity.Type, entity.Variant or 0, entity.SubType or 0, 19)
			end
		end
	end
end)

onActiveUse(i.DeliriousVeggie, function()
	entities = Isaac.GetRoomEntities()
	for i, entity in pairs(entities) do
		if entity.Type == EntityType.ENTITY_DELIRIUM then
			Isaac.Spawn(et.SkinlessDelirium, ev.SkinlessDelirium, 0, entity.Position, Vector(0,0), nil)
			entity:Remove()
		end
	end

	player:RemoveCollectible(i.DeliriousVeggie)
	return true
end)

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, function()
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, i.DeliriousVeggie, room:FindFreePickupSpawnPosition(room:GetCenterPos(), 0, false), zeroVector, nil)
end, EntityType.ENTITY_HUSH)

-- !!!!!TWINEKTS!!!!!!

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function()
	player = Isaac.GetPlayer(0)
	if player:HasTrinket(t.Diarrhea) then
		room = game:GetRoom()
		local gridSize = room:GetGridSize()
		for i=0,gridSize,1 do
			local currentGrid = room:GetGridEntity(i)
			if currentGrid ~= nil then
				if currentGrid:GetType() == GridEntityType.GRID_POOP then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_SLIPPERY_BROWN, 0, currentGrid.Position, Vector(0,0), nil)
					currentGrid:Destroy()
				end
			end
		end
	end
	if player:HasTrinket(t.Streamdeck) then
		local x2 = player.Velocity.X * player.Velocity.X
		local y2 = player.Velocity.Y * player.Velocity.Y
		local mag = math.floor(math.sqrt(x2 + y2))
		f.sfxCountdown = f.sfxCountdown - 1
		if f.sfxCountdown <= 0 and mag ~= 0 then
			sfx:Play(api.Random(SoundEffect.NUM_SOUND_EFFECTS), 1, 0, false, 1)
			f.sfxCountdown = 30/mag
		end
	end
	if player:HasTrinket(t.BigNo) then
		if player:GetActiveItem() ~= nil then
			f.noCountdown = f.noCountdown - 1
			if f.noCountdown <= 0 then
				player:TakeDamage(1, 0, EntityRef(player), 0)
				f.noCountdown = 150
			end
		end
	end
	if player:HasTrinket(t.IceCube) then
		entities = Isaac.GetRoomEntities()
		for i, entity in pairs(entities) do
			if game:GetFrameCount() % 3 == 0 then
				if entity:IsActiveEnemy() then
					local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_SLIPPERY_BROWN, 56, entity.Position, zeroVector, nil):ToEffect()
					effect:SetTimeout(30)
				end
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
					Isaac.Spawn(enemyNumbers[api.Random(#enemyNumbers + 1)], 0, 0, thisEnt.Position, Vector(0,0), nil)
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
				if player:HasCollectible(i.SlapBean) then
					sfx:Play(s.Slap, 1, 0, false, 1)
				end
				if player:HasCollectible(i.LeakyBean) then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, thisEnt.Position, Vector(0,0), nil)
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

local function SpawnRandomBean()
	local bean = api.Random(1,2)
	local variant
	local subtype
	if bean == 1 then
		variant = ev.MoreJellyBean
		subtype = api.Random(7)
	elseif bean == 2 then
		variant = Isaac.GetEntityVariantByName("Jelly Bean Red")
		subtype = api.Random(12)
	end
	Isaac.Spawn(EntityType.ENTITY_PICKUP, variant, subtype,  room:FindFreePickupSpawnPosition(player.Position, 0, true), Vector(0,0), entity)
end

onPickupPickup(ev.MoreJellyBean, function(p, player)
    local filename = p:GetSprite():GetFilename()
    local flavor = jellyBeanFlavors[filename]
    if flavor then
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

	if player:HasCollectible(i.DoubleBean) then
		SpawnRandomBean()
		SpawnRandomBean()
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
	sfx:Play(s.RustedPenny, 1, 0, false, 1)
    f.RustedPenny = true
end)

onPickupPickup(ev.RustedKey, function(p)
	sfx:Play(s.RustedKey, 1, 0, false, 1)
    f.RustedKey = true
end)

onPickupPickup(ev.RustedBomb, function(p)
	sfx:Play(s.RustedBomb, 1, 0, false, 1)
	f.RustedBomb = true
end)

onPickupPickup(ev.RustedHeart, function(p)
	sfx:Play(s.RustedHeart, 1, 0, false, 1)
	player:AddHearts(-2)
end)

onPickupPickup(ev.RustedBattery, function(p)
	sfx:Play(s.RustedBattery, 1, 0, false, 1)
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
	Isaac.Spawn(enemyNumbers[api.Random(#enemyNumbers) + 1], 0, 0, room:GetCenterPos(), Vector(0,0), nil)
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
		player:AddCollectible(api.Random(numCollectibles) + 1, 0, false)
	end
end)

onPillUse(pi.ThreeDots, function()
	local sub = api.Random(2)
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
		data.yahoo = true
	else
		if not sprite:IsPlaying("Appear") then
            if data.cooldown > 0 then
                data.cooldown = data.cooldown - 1
            end

            if data.cooldown == 0 and data.hopping == false then
                sprite:Play("Hop", true)
				if data.yahoo then
					if entity.SubType == es.Logo then
						sfx:Play(s.Yahoo, 1, 0, false, 1.1)
					else
						sfx:Play(s.Yahoo, 1, 0, false, 1)
					end
					data.yahoo = false
				end
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
				data.yahoo = true
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
		sfx:Play(SoundEffect.SOUND_BOSS_SPIT_BLOB_BARF, 1, 0, false, 1.1)
	end
end, ev.Sickstro)

replaceEntity(EntityType.ENTITY_HOPPER, nil, nil, et.Muro, ev.Muro, nil, 8)
replaceEntity(EntityType.ENTITY_HOPPER, nil, nil, et.Muro, ev.Muro, es.Logo, 8)
replaceEntity(EntityType.ENTITY_MAW, nil, nil, EntityType.ENTITY_MAW, ev.Nostro, nil, 4)
replaceEntity(EntityType.ENTITY_HORF, nil, nil, EntityType.ENTITY_HORF, ev.Tomato, nil, 4)
replaceEntity(EntityType.ENTITY_MINISTRO, nil, nil, EntityType.ENTITY_MINISTRO, ev.Sickstro, nil, 4)

local function amogusManager()
	amogusList[1].Position = room:GetCenterPos() + Vector(26, -26)
	if #amogusList >= 2 then
		amogusList[2].Position = room:GetCenterPos() + Vector(-26, -26)
	end
	if #amogusList >= 3 then
		amogusList[3].Position = room:GetCenterPos() + Vector(26, 26)
	end
	if #amogusList >= 4 then
		amogusList[4].Position = room:GetCenterPos() + Vector(-26, 26)
	end
	amogusList[api.Random(1, #amogusList)]:ToNPC().State = NpcState.STATE_ATTACK2
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	local amogus = api.Random(1,10)
	room = game:GetRoom()
	if amogus == 10 and not room:IsClear() then
		local entities = Isaac.GetRoomEntities()
		local amogusAmount = 4
		local amogusIndex = 1
		amogusList = {}
		local newAmogus
		for i, entity in pairs(entities) do
			if entity:IsEnemy() and not entity:IsBoss() then
				if amogusAmount > 0 then
					newAmogus = Isaac.Spawn(et.Amogus, ev.Amogus, 0, entity.Position, Vector(0,0), nil)
					entity:Remove()
					amogusAmount = amogusAmount - 1
					amogusList[amogusIndex] = newAmogus
					amogusIndex = amogusIndex + 1
				end
			end
		end
		amogusManager()
	end
end)

onEntityTick(et.Amogus, function(entity)
	entity = entity:ToNPC()
	local data = entity:GetData()
	local sprite = entity:GetSprite()

	if entity.State == NpcState.STATE_INIT then
		entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
		entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
		data.countdown = 0
		entity.State = NpcState.STATE_ATTACK
	else
		if entity.State == NpcState.STATE_ATTACK2  then
			entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
			sprite:Play("VentOut", false)
			if sprite:IsEventTriggered("Vulnerable") then
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				sfx:Play(s.Vent, 1, 0, false, 1)
			end
			if sprite:IsFinished("VentOut") then
				data.countdown = 60
				entity.State = NpcState.STATE_ATTACK4
			end
		end
		if entity.State == NpcState.STATE_ATTACK4 then
			sprite:Play("Idle", false)
			data.countdown = data.countdown - 1
			if data.countdown <= 0 then
				entity.State = NpcState.STATE_ATTACK3
			end
		end
		if entity.State == NpcState.STATE_ATTACK3 then
			sprite:Play("VentIn", false)
			if sprite:IsEventTriggered("Invulnerable") then
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				amogusManager()
			end
			if sprite:IsFinished("VentIn") then
				entity.State = NpcState.STATE_ATTACK
			end
		end
		if entity.State == NpcState.STATE_ATTACK then
			sprite:Play("Vent", false)
		end
	end
	if entity:IsDead() then
		entities = Isaac.GetRoomEntities()
		for i, entity in pairs(entities) do
			if entity.Type == et.Amogus and entity.Variant == ev.Amogus then
				entity:Kill()
			end
		end
	end
end, ev.Amogus)


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
				sfx:Play(SoundEffect.SOUND_LITTLE_HORN_GRUNT_1, 1, 0, false, 1.2)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_TROLL, entity.Position, Vector(0,0), nil)
			end
			if sprite:IsFinished("Bomb") then
				entity.State = NpcState.STATE_MOVE
			end
		end
	end
	if sprite:IsPlaying("Death") then
		if entity.SubType == es.DeliriumLittlestHorn then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
					entity:Kill()
				end
			end
		end
	end
end, ev.LittlestHorn)

local imposterParams = ProjectileParams()
imposterParams.BulletFlags = ProjectileFlags.RED_CREEP
imposterParams.Scale = 3

onEntityTick(et.Imposter, function(entity)
	entity = entity:ToNPC()
	local data = entity:GetData()
	local sprite = entity:GetSprite()

	if entity.State == NpcState.STATE_INIT then
		vents = {}
		local activeVent
		local attack
		vents[1] = Isaac.Spawn(et.Vent, ev.Vent, 0, room:GetTopLeftPos() + Vector(65, 26), Vector(0,0), nil)
		vents[2] = Isaac.Spawn(et.Vent, ev.Vent, 0, Vector(room:GetTopLeftPos().X, room:GetBottomRightPos().Y) + Vector(65, -26), Vector(0,0), nil)
		vents[3] = Isaac.Spawn(et.Vent, ev.Vent, 0, Vector(room:GetBottomRightPos().X, room:GetTopLeftPos().Y) + Vector(-65, 26), Vector(0,0), nil)
		vents[4] = Isaac.Spawn(et.Vent, ev.Vent, 0, room:GetBottomRightPos() + Vector(-65, -26), Vector(0,0), nil)
		entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_GROUND
		entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK)
		data.moveCountdown = 0
		data.rocketCountdown = 0
		data.rocketAmount = 0
		data.barfCooldown = 0
		data.barfCoolup = 0
		data.playerPos = Vector(0,0)

		entity.State = NpcState.STATE_ATTACK
	else
		if entity.State == NpcState.STATE_ATTACK2  then
			entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
			sprite:Play("VentOut", false)
			activeVent:GetSprite():Play("VentOut", false)
			if sprite:IsEventTriggered("Vulnerable") then
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				sfx:Play(s.Vent, 1, 0, false, 1)
			end
			if sprite:IsFinished("VentOut") then
				data.moveCountdown = 60
				entity.State = NpcState.STATE_ATTACK4
			end
		end
		if entity.State == NpcState.STATE_ATTACK4 then
			sprite:Play("Idle", false)
			activeVent:GetSprite():Play("Idle", false)
			data.moveCountdown = data.moveCountdown - 1
			if data.moveCountdown <= 0 then
				attack = api.Random(1,2)
				if attack == 1 then
					data.rocketCountdown = 15
					data.rocketAmount = 3
					sprite:Play("Unholster", false)
					sfx:Play(s.Death, 1, 0, false, 1)
					entity.State = NpcState.STATE_SUMMON
				end
				if attack == 2 then
					data.barfCooldown = 60
					data.barfCoolup = 30
					sprite:Play("Bend", false)
					sfx:Play(s.RoleReveal, 1, 0, false, 1)
					entity.State = NpcState.STATE_SUMMON2
				end
			end
		end
		if entity.State == NpcState.STATE_SUMMON then
			if sprite:IsFinished("Unholster") or sprite:IsFinished("FireGun") then
				sprite:Play("IdleGun", false)
			end
			data.rocketCountdown = data.rocketCountdown - 1
			if data.rocketCountdown <= 0 then
				if data.rocketAmount <= 0 then
					sprite:Play("Holster", false)
					if sprite:IsFinished("Holster") then
						entity.State = NpcState.STATE_ATTACK3
					end
				else
					sprite:Play("FireGun", false)
					sfx:Play(s.Gunshot, 1, 0, false, 1)
					Isaac.Spawn(et.ImposterMissle, ev.ImposterMissle, 0, player.Position, Vector(0,0), nil)
					data.rocketCountdown = 15
					data.rocketAmount = data.rocketAmount - 1
				end
			end
		end
		if entity.State == NpcState.STATE_SUMMON2 then
			data.barfCooldown = data.barfCooldown - 1
			if sprite:IsFinished("Bend") then
				sprite:Play("Charge", false)
			end
			if data.barfCooldown == 0 then
				sprite:Play("OpenMouth", false)
				data.playerPos = player.Position
				sfx:Play(SoundEffect.SOUND_MEGA_PUKE, 1, 0, false, 1)
			end
			if data.barfCooldown <= 0 then
				if sprite:IsFinished("OpenMouth") then
					sprite:Play("Vomiting", false)
				end
				entity:FireBossProjectiles(1, data.playerPos, 0, imposterParams)
				data.barfCoolup = data.barfCoolup - 1
				if data.barfCoolup <= 0 then
					sprite:Play("CloseMouth", false)
					if sprite:IsFinished("CloseMouth") then
						entity.State = NpcState.STATE_ATTACK3
					end
				end
			end
		end
		if entity.State == NpcState.STATE_ATTACK3 then
			sprite:Play("VentIn", false)
			activeVent:GetSprite():Play("VentIn", false)
			if sprite:IsEventTriggered("Invulnerable") then
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
			end
			if sprite:IsFinished("VentIn") then
				entity.State = NpcState.STATE_ATTACK
			end
		end
		if entity.State == NpcState.STATE_ATTACK then
			activeVent = vents[api.Random(1,4)]
			if activeVent == vents[3] or activeVent == vents[4] then
				sprite.FlipX = true
			else
				sprite.FlipX = false
			end
			sprite:Play("Vent", false)
			activeVent:GetSprite():Play("Idle", false)
			entity.Position = activeVent.Position + Vector(0,5)
			entity.State = NpcState.STATE_ATTACK2
		end
	end
	if entity:IsDead() then
		entities = Isaac.GetRoomEntities()
		for i, j in pairs(entities) do
			if j.Type == et.Vent and j.Variant == ev.Vent then
				j:Kill()
			end
			if entity.SubType == es.DeliriumImposter then
				if j.Type == et.SkinlessDelirium and j.Variant == ev.SkinlessDelirium then
					j:Kill()
				end
			end
		end
		sfx:Play(s.Victory, 1, 0, false, 1)
	end
end, ev.Imposter)

onEntityTick(et.ImposterMissle, function(entity)
	local data = entity:GetData()
	if entity.FrameCount <= 0 then
		data.target = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, player.Position, Vector(0,0), nil)
		data.cooldown = 60
	else
		data.cooldown = data.cooldown - 1
		if data.cooldown <= 0 then
			Isaac.Explode(data.target.Position, nil, 1)
			data.target:Remove()
			entity:Remove()
		end
	end
end, ev.ImposterMissle)

onEntityTick(EntityType.ENTITY_MONSTRO, function(entity)
	entity = entity:ToNPC()
	local sprite = entity:GetSprite()

	if sprite:IsEventTriggered("Barf") then
		for i = 1, api.Random(32, 64) do
			monstroParams.VelocityMulti = api.Random(0, 3000) * 0.0007
			entity:FireBossProjectiles(1, player.Position, 0, monstroParams)
		end
		sfx:Play(SoundEffect.SOUND_BOSS_SPIT_BLOB_BARF, 1, 0, false, 1.1)
	end
	if sprite:IsEventTriggered("Land") then
		for i = 1, 2 do
			local laser = EntityLaser.ShootAngle(1, entity.Position, api.GetCircleDegreeOffset(i, 2), 180, zeroVector, entity)
			laser:SetActiveRotation(60, 360 * 500, 1.5, false)
		end
	end
	local rando = api.Random(1,100000)
	if rando == 1 then
		Isaac.Explode(entity.Position, nil, 0)
		entity:Remove()
	end
	if sprite:IsPlaying("Death") then
		if entity.SubType == es.DeliriumMonstro3 then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
					entity:Kill()
				end
			end
		end
	end
end, ev.Monstro3)

onEntityTick(et.SkinlessDelirium, function(entity)
	entity = entity:ToNPC()
	local data = entity:GetData()
	local sprite = entity:GetSprite()

	if entity.FrameCount <= 0 then
		entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK)
		data.boss = nil
		f.deliCoundtown = 60
		f.attackCountdown = 30
		sprite:Play("Idle", false)
	else
		entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK | EntityFlag.FLAG_NO_KNOCKBACK)
		f.deliCountdown = f.deliCountdown - 1
		f.attackCountdown = f.attackCountdown - 1
		if data.boss ~= nil then
			entity.HitPoints = data.boss.HitPoints
		end
		if f.deliCountdown <= 0 then
			local become = api.Random(1,8)
			if data.boss ~= nil then
				--entity.HitPoints = data.boss.HitPoints
				data.boss:Remove()
			end
			entities = Isaac.GetRoomEntities()
			for i, j in pairs(entities) do
				if j.Type == et.Vent and j.Variant == ev.Vent then
					j:Remove()
				end
			end
			if become == 4 then
				entity.Visible = true
				entity.MaxHitPoints = 10001
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
				sprite:Play("Blink", false)
			else
				entity.Visible = false
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				if become == 1 then
					data.boss = Isaac.Spawn(et.Imposter, ev.Imposter, es.DeliriumImposter, entity.Position, Vector(0,0), nil)
				end
				if become == 2 then
					data.boss = Isaac.Spawn(et.LittlestHorn, ev.LittlestHorn, es.DeliriumLittlestHorn, entity.Position, Vector(0,0), nil)
				end
				if become == 3 then
					data.boss = Isaac.Spawn(EntityType.ENTITY_MONSTRO, ev.Monstro3, es.DeliriumMonstro3, entity.Position, Vector(0,0), nil)
				end
				if become == 5 then
					data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Nerve Ending 3"), Isaac.GetEntityVariantByName("Nerve Ending 3"), es.DeliriumNerve3, entity.Position, Vector(0,0), nil)
				end
				if become == 6 then
					data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Medium Horn"), Isaac.GetEntityVariantByName("Medium Horn"), es.DeliriumMediumHorn, entity.Position, Vector(0,0), nil)
				end
				if become == 7 then
					data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Abortionbirth SECRET BOSS"), Isaac.GetEntityVariantByName("Abortionbirth SECRET BOSS"), es.DeliriumSecretBoss, entity.Position, Vector(0,0), nil)
				end
				if become == 8 then
					data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("??? but Red"), Isaac.GetEntityVariantByName("??? but Red"), es.DeliriumPrecursor, entity.Position, Vector(0,0), nil)
				end
				-- if become == 9 then
				-- 	data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Ultra Envy"), Isaac.GetEntityVariantByName("Ultra Envy"), es.DeliriumUltraEnvy, entity.Position, Vector(0,0), nil)
				-- end
				-- if become == 10 then
				-- 	data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Santa"), Isaac.GetEntityVariantByName("Santa"), es.DeliriumSanta, entity.Position, Vector(0,0), nil)
				-- end
				-- if become == 9 then
				-- 	data.boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Mega Ultra Envy"), Isaac.GetEntityVariantByName("Mega Ultra Envy"), es.DeliriumMegaUltraEnvy, entity.Position, Vector(0,0), nil)
				-- end
				data.boss.HitPoints = entity.HitPoints
			end
			entity.Position = Vector(api.Random(0,room:GetBottomRightPos().X), api.Random(0,room:GetBottomRightPos().Y))
			sfx:Play(SoundEffect.SOUND_HELL_PORTAL1, 1, 0, false, 1)
			sfx:Play(SoundEffect.SOUND_HELL_PORTAL2, 1, 0, false, 1)
			f.deliCountdown = api.Random(60,150)
		end
		if sprite:IsFinished("Blink") then
			sprite:Play("Idle", false)
		end
		if f.attackCountdown == 0 then
			local attack = api.Random(1,4)
			if attack == 1 then
				if entity.Visible then
					for i = 1, 8 do
		                local laser = EntityLaser.ShootAngle(1, entity.Position, api.GetCircleDegreeOffset(i, 8), 60, zeroVector, entity)
		                laser:SetActiveRotation(60, 360 * 500, 1.5, false)
		            end
				else
					for i = 1, 8 do
						local laser = EntityLaser.ShootAngle(1, data.boss.Position, api.GetCircleDegreeOffset(i, 8), 60, zeroVector, data.boss)
						laser:SetActiveRotation(60, 360 * 500, 1.5, false)
					end
				end
			end
			f.attackCountdown = api.Random(30,75)
		end
	end
	if entity:IsDead() then
		entities = Isaac.GetRoomEntities()
		for i, entity in pairs(entities) do
			if entity.Type == et.Vent and entity.Variant == ev.Vent then
				entity:Kill()
			end
		end
		data.boss:Kill()
	end

end, ev.SkinlessDelirium)

onEntityTick(Isaac.GetEntityTypeByName("Nerve Ending 3"), function(entity)
	if entity.HitPoints <= 0 then
		if entity.SubType == es.DeliriumNerve3 then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
					entity:Kill()
				end
			end
		end
	end
end, Isaac.GetEntityVariantByName("Nerve Ending 3"))

onEntityTick(Isaac.GetEntityTypeByName("Medium Horn"), function(entity)
	local sprite = entity:GetSprite()
	if sprite:IsPlaying("Death") then
		if entity.SubType == es.DeliriumMediumHorn then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
					entity:Kill()
				end
			end
		end
	end
end, Isaac.GetEntityVariantByName("Medium Horn"))

onEntityTick(Isaac.GetEntityTypeByName("Abortionbirth SECRET BOSS"), function(entity)
	local sprite = entity:GetSprite()
	if sprite:IsPlaying("Death") then
		if entity.SubType == es.DeliriumSecretBoss then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
					entity:Kill()
				end
			end
		end
	end
end, Isaac.GetEntityVariantByName("Abortionbirth SECRET BOSS"))

onEntityTick(Isaac.GetEntityTypeByName("??? but Red"), function(entity)
	local sprite = entity:GetSprite()
	if sprite:IsPlaying("Death") then
		if entity.SubType == es.DeliriumPrecursor then
			entities = Isaac.GetRoomEntities()
			for i, entity in pairs(entities) do
				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
					entity:Kill()
				end
			end
		end
	end
end, Isaac.GetEntityVariantByName("??? but Red"))

-- a lot of these bosses dont work properly, and implementing them correctly would
-- require modification of base borty code. sowwy!!
-- onEntityTick(Isaac.GetEntityTypeByName("Ultra Envy"), function(entity)
-- 	if entity:IsDead() then
-- 		if entity.SubType == es.DeliriumUltraEnvy then
-- 			entities = Isaac.GetRoomEntities()
-- 			for i, entity in pairs(entities) do
-- 				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
-- 					entity:Kill()
-- 				end
-- 			end
-- 		end
-- 	end
-- end, Isaac.GetEntityVariantByName("Ultra Envy"))

-- onEntityTick(Isaac.GetEntityTypeByName("Santa"), function(entity)
-- 	local sprite = entity:GetSprite()
-- 	if sprite:IsPlaying("Death") then
-- 		if entity.SubType == es.DeliriumSanta then
-- 			entities = Isaac.GetRoomEntities()
-- 			for i, entity in pairs(entities) do
-- 				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
-- 					entity:Kill()
-- 				end
-- 			end
-- 		end
-- 	end
-- -- end, Isaac.GetEntityVariantByName("Santa"))
--
-- onEntityTick(Isaac.GetEntityTypeByName("Mega Ultra Envy"), function(entity)
-- 	local sprite = entity:GetSprite()
-- 	if sprite:IsPlaying("Death") then
-- 		if entity.SubType == es.DeliriumMegaUltraEnvy then
-- 			entities = Isaac.GetRoomEntities()
-- 			for i, entity in pairs(entities) do
-- 				if entity.Type == et.SkinlessDelirium and entity.Variant == ev.SkinlessDelirium then
-- 					entity:Kill()
-- 				end
-- 			end
-- 		end
-- 	end
-- end, Isaac.GetEntityVariantByName("Mega Ultra Envy"))

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
