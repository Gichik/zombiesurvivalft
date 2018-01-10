if somewill_map == nil then
	_G.somewill_map = class({})
end	

LinkLuaModifier("modifier_fullness", "modifiers/modifier_fullness.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_peppy", "modifiers/modifier_peppy.lua", LUA_MODIFIER_MOTION_NONE )

ITEM_SET = 0;

function somewill_map:InitGameMode()
	print( "InitGameMode" )
	EmitGlobalSound("ZombieSurvivalFT.IntroGrowl")
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 3 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetTimeOfDay( 0.5 )	
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 0.0 )
	GameRules:SetStrategyTime( 0.0 )
	GameRules:SetShowcaseTime( 0.0 )
	GameRules:SetPreGameTime( 5.0 )		
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 60.0 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:SetStartingGold( 0 )


	GameRules:GetGameModeEntity():SetBuybackEnabled( false )
	GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )

	GameRules:GetGameModeEntity():SetCustomGameForceHero('npc_dota_hero_rattletrap');

	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel( 1 )
	--GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")

	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(somewill_map, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(somewill_map, "OnEntityKilled"), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(somewill_map, 'GameRulesStateChange'), self)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(somewill_map, 'OnPlayerGainedLevel'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(somewill_map, 'OnNPCSpawn'), self)

	--AddFOWViewer( DOTA_TEAM_NEUTRALS, Vector(0,0,0), 10000, -1, false)
	--AddFOWViewer( DOTA_TEAM_BADGUYS, Vector(0,0,0), 10000, -1, false)
end

function somewill_map:OnNPCSpawn(data)
	local unit = EntIndexToHScript(data.entindex)
	if unit:IsHero() then
		
		if not unit.next_spawn then
			unit.next_spawn = true;	
			unit:AddNewModifier(unit, nil, "modifier_fullness", {duration = 120})
			unit:AddNewModifier(unit, nil, "modifier_peppy", {duration = 230})
			unit:SetGold(0,false)

			somewill_map:AddStartItemToPlayer(unit)

			if unit:HasAbility("forward_vision") then
				unit:FindAbilityByName("forward_vision"):SetLevel(1)
			end	

			if unit:HasAbility("provision_search") then
				unit:FindAbilityByName("provision_search"):SetLevel(1)
			end			

		end
	end
end

 function somewill_map:GameRulesStateChange(keys)
	local newState = GameRules:State_Get()

	if newState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		somewill_map:SpawnSettings()
	end

	if newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		EmitGlobalSound("ZombieSurvivalFT.IntroStart")
	end

	if newState == DOTA_GAMERULES_STATE_PRE_GAME then 
		--Timers:CreateTimer(3, function()
		--		return nil
		--end)
	end

	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then 
		--somewill_map:AddStartItemToPlayer()
		somewill_map:ZombieVoice()
		

		GameRules:GetGameModeEntity():SetContextThink(string.format("MusicThink_%d",1), 
			function()
				if #TABLE_RANDOM_MUSIC == 0 then
					GenerateTableMusic()
				end

				local musicName = TABLE_RANDOM_MUSIC[1]
				table.remove(TABLE_RANDOM_MUSIC, 1)

				if not musicName then
					musicName = "HansZimmer_SamarasSong"
				end
				GameRules:SendCustomMessage(string.gsub(musicName, "_", " - "), 0, 0)
				--Say(nil,string.gsub(musicName, "_", " - "), false)
				EmitGlobalSound("ZombieSurvivalFT." .. musicName)
				return 240
			end,
			5)

		-- 4 минуты день, 3 ночь
		Timers:CreateTimer(240, function()
			GameRules:SetTimeOfDay( 0.875 )
			return 420.0
		end
		)
	
	end
end

function somewill_map:OnPlayerGainedLevel(data)
	local hero = PlayerResource:GetSelectedHeroEntity(data.player-1)
	hero:SetAbilityPoints(0)
end

function somewill_map:OnSomeHeroKilled(data)
	--print("hero killed")

	local killedHero = PlayerResource:GetSelectedHeroEntity(data.PlayerID)

--[[
	local newItem = CreateItem( "item_tombstone", killedHero, killedHero )
	newItem:SetPurchaseTime( 0 )
	newItem:SetPurchaser( killedHero )
	local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
	tombstone:SetContainedItem( newItem )
	tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
	FindClearSpaceForUnit( tombstone, killedHero:GetAbsOrigin(), true )	

	local AllDead = true

	for i=0,5 do
		if PlayerResource:IsValidPlayer(i) then
			if PlayerResource:GetSelectedHeroEntity(i):IsAlive() then
				AllDead = false
			end
		end
	end

	if AllDead then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	end]]
end

function somewill_map:OnEntityKilled(data)
   local killedEntity = EntIndexToHScript(data.entindex_killed)
	--print("entity killed")
    if killedEntity:IsRealHero() then
		local newItem = CreateItem( "item_tombstone", killedEntity, killedEntity )
		newItem:SetPurchaseTime( 0 )
		newItem:SetPurchaser( killedEntity )
		local tombstone = SpawnEntityFromTableSynchronous( "dota_item_tombstone_drop", {} )
		tombstone:SetContainedItem( newItem )
		tombstone:SetAngles( 0, RandomFloat( 0, 360 ), 0 )
		FindClearSpaceForUnit( tombstone, killedEntity:GetAbsOrigin(), true )

		for i = 0, 8 do 
			item = killedEntity:GetItemInSlot(i)
			if item ~= nil then
				killedEntity:DropItemAtPositionImmediate(item,killedEntity:GetAbsOrigin() + RandomVector(RandomFloat(50, 100)))
			end
		end

		local AllDead = true
		local playerCount = PlayerResource:GetTeamPlayerCount()

		for i=0, playerCount  do
			if PlayerResource:IsValidPlayer(i) then
				if PlayerResource:GetSelectedHeroEntity(i):IsAlive() then
					AllDead = false
				end
			end
		end

		if AllDead then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end
	end	

    if killedEntity:IsCreature() then
		if killedEntity:GetUnitName() == "npc_generator" or killedEntity:GetUnitName() == "npc_scientific_table" then
			GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end

		if killedEntity:GetUnitName():find("box") then
			somewill_map:SpawnScreamZombies(killedEntity:GetAbsOrigin(), 1000)
		end
    end

end

function somewill_map:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end  


function somewill_map:SpawnSettings()
	--print("BiomSpawnSettings")

	Timers:CreateTimer(5, function()
		if GameRules:IsDaytime() == false then
			somewill_map:SpawnNightZombies()
		end
		return 20.0
	end
	)

	somewill_map:SpawnQuestIten("spawn_quest_item_1", "item_employee_card")
	somewill_map:SpawnQuestIten("spawn_quest_item_2", "item_explosive")
	somewill_map:SpawnQuestIten("spawn_quest_item_3", "item_fire_extinguisher")


	local point = Entities:FindByName(nil,"spawn_door_1"):GetAbsOrigin()
	local unit = CreateUnitByName("npc_military_door", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
	unit:SetHullRadius(100)
	unit:SetForwardVector(Vector(0,1,0))
	unit:SetRenderColor(0, 102, 51)

	point = Entities:FindByName(nil,"spawn_door_2"):GetAbsOrigin()
	unit = CreateUnitByName("npc_car_door", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
	unit:SetHullRadius(100)
	unit:SetForwardVector(Vector(0,1,0))
	unit:SetRenderColor(0, 0, 0)

	point = Entities:FindByName(nil,"spawn_door_3"):GetAbsOrigin()
	unit = CreateUnitByName("npc_fire_door", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
	unit:SetHullRadius(100)
	unit:SetForwardVector(Vector(0,1,0))
	unit:SetRenderColor(0, 0, 0)

	point = Entities:FindByName(nil,"spawn_base_1"):GetAbsOrigin()
	unit = CreateUnitByName("npc_scientific_table", point , true, nil, nil, DOTA_TEAM_GOODGUYS )
	unit:SetForwardVector(Vector(0,-1,0))

	point = Entities:FindByName(nil,"spawn_base_2"):GetAbsOrigin()
	unit = CreateUnitByName("npc_generator", point , true, nil, nil, DOTA_TEAM_GOODGUYS )

	local entity = nil

	for i = 1, 30 do
		entity = Entities:FindByName(nil,"spawn_static_zombie_" .. i)
		if entity then
			somewill_map:SpawnStaticZombie(entity:GetAbsOrigin(), 4)
		end
	end
	
	for i = 1, 20 do
		entity = Entities:FindByName(nil,"spawn_military_" .. i)
		if entity then
			local point = entity:GetAbsOrigin()
			local unit = CreateUnitByName("npc_military_box", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
			unit:SetRenderColor(0, 102, 51)
		end
	end

	for i = 1, 20 do
		entity = Entities:FindByName(nil,"spawn_city_" .. i)
		if entity then
			local point = entity:GetAbsOrigin()
			local unit = CreateUnitByName("npc_city_box", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
			unit:SetRenderColor(128, 128, 128)
		end
	end

	for i = 1, 20 do
		entity = Entities:FindByName(nil,"spawn_farm_" .. i)
		if entity then
			local point = entity:GetAbsOrigin()
			local unit = CreateUnitByName("npc_food_box", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
		end
	end

end

function somewill_map:AddStartItemToPlayer(hero)
	ITEM_SET = ITEM_SET + 1

	if hero:HasAnyAvailableInventorySpace() then
		if ITEM_SET == 1 then
			hero:AddItemByName("item_katana")
			hero:AddItemByName("item_food_canned")
			hero:AddItemByName("item_sleeping_tablet")
		end
		if ITEM_SET == 2 then
			hero:AddItemByName("item_pistol")
			hero:AddItemByName("item_pistol_ammo")
			hero:AddItemByName("item_pistol_ammo")						
			hero:AddItemByName("item_food_canned")
			hero:AddItemByName("item_sleeping_tablet")
		end
		if ITEM_SET == 3 then
			hero:AddItemByName("item_shotgun")
			hero:AddItemByName("item_shotgun_ammo")
			hero:AddItemByName("item_shotgun_ammo")			
			hero:AddItemByName("item_food_canned")
			hero:AddItemByName("item_sleeping_tablet")
		end		
	end	
	--[[
	for i = 0, PlayerResource:GetPlayerCount()-1 do
		local hero = PlayerResource:GetSelectedHeroEntity(i)
		if hero then
			for j = 0, 8 do
				local item = hero:GetItemInSlot(j)
				if item then
					hero:RemoveItem(item)
				end
			end	
		end
	end]]
end

function somewill_map:FocusCameraOnPlayer(player)
	PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CameraThink_%d", player:GetPlayerOwnerID()), 
	function()
		PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)	
	return nil
	end,
	1)
end

function somewill_map:SpawnStaticZombie(point, quantity)
	local unit, position = nil, nil
	unit = CreateUnitByName("npc_corpse", point , true, nil, nil, DOTA_TEAM_BADGUYS )
	for i = 1, quantity do
		unit = CreateUnitByName("npc_static_zombie", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
	end
end

function somewill_map:SpawnScreamZombies(point, radius)
	local ent = Entities:FindAllInSphere(point,radius)
	if ent then
		for i = 1, #ent do
			if ent[i]:GetName():find("spawn_screamer") then
				CreateUnitByName("npc_scream_zombie", ent[i]:GetAbsOrigin() , true, nil, nil, DOTA_TEAM_NEUTRALS )
			end	
		end		
	end
end

function somewill_map:SpawnNightZombies()
	local entity, point = nil, nil
	local presentTime = GameRules:GetDOTATime(false,false)

	for i = 1, 3 do
		entity = Entities:FindByName(nil,"spawn_night_zombie_" .. i)
		if entity then
			point = entity:GetAbsOrigin()
			for j = 1, 8 do
				CreateUnitByName("npc_night_zombie", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
			end
			if presentTime > 650 then
				CreateUnitByName("npc_night_mutant", point , true, nil, nil, DOTA_TEAM_NEUTRALS )
			end
		end
	end		
end

function somewill_map:SpawnQuestIten(entName, itemName)
	local point = Entities:FindByName(nil,entName):GetAbsOrigin()
	local newItem = CreateItem(itemName, nil, nil)
	local drop = CreateItemOnPositionSync(point,newItem)
	if drop then
	    drop:SetContainedItem( newItem )
	end
end


function somewill_map:ZombieVoice()
	Timers:CreateTimer(5, function()
		EmitGlobalSound(TABLE_ZOMBIE_GROWL[RandomInt(1,#TABLE_ZOMBIE_GROWL)])
		return 10.0
	end)
end