if test_map == nil then
	_G.test_map = class({})
end	

LinkLuaModifier("modifier_fullness", "modifiers/modifier_fullness.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_peppy", "modifiers/modifier_peppy.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_cold", "modifiers/modifier_cold.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_heat", "modifiers/modifier_heat.lua", LUA_MODIFIER_MOTION_NONE )

function test_map:InitGameMode()
	print( "InitGameMode" )
	EmitGlobalSound("ZombieSurvivalFT.IntroGrowl")
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 4 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )

	GameRules:SetTimeOfDay( 0.5 )	
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 15.0 )
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

	

	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel( 1 )
	GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")

	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(test_map, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(test_map, "OnEntityKilled"), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(test_map, 'GameRulesStateChange'), self)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(test_map, 'OnPlayerGainedLevel'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(test_map, 'OnNPCSpawn'), self)

	AddFOWViewer( DOTA_TEAM_NEUTRALS, Vector(0,0,0), 10000, -1, false)
	--AddFOWViewer( DOTA_TEAM_BADGUYS, Vector(0,0,0), 10000, -1, false)

	unit = CreateUnitByName("npc_kitchen_table", Vector(-640,512,128) , true, nil, nil, DOTA_TEAM_GOODGUYS )

	--local newItem = CreateItem("item_military_cage", nil, nil)
	local point = Entities:FindByName(nil,"spawn_items_1"):GetAbsOrigin()
	--newItem:SetPurchaseTime(0)
	--CreateItemOnPositionSync(point, newItem)
	unit = CreateUnitByName("military_box", point , true, nil, nil, DOTA_TEAM_BADGUYS )
	unit:SetHullRadius(70)
	--local ballTable =
	--{
	--	origin = point,
	--	model = "models/heroes/juggernaut/jugg_healing_ward.vmdl"
	--}
	--ballTable["spawnflags#6"] = "1"
	--local redBall = SpawnEntityFromTableSynchronous( "prop_dynamic", ballTable )
	--FindClearSpaceForUnit( redBall, point, true )

	point = Entities:FindByName(nil,"spawn_door_1"):GetAbsOrigin()
	unit = CreateUnitByName("npc_military_door", point , true, nil, nil, DOTA_TEAM_BADGUYS )
	unit:SetHullRadius(100)
	unit:SetForwardVector(Vector(0,1,0))
end

function test_map:OnNPCSpawn(data)
	local unit = EntIndexToHScript(data.entindex)

	if unit:GetUnitName() == "npc_military_door" then
		unit:SetRenderColor(48, 153, 43)
	end

	if unit:IsHero() then
		if not unit.next_spawn then
			unit.next_spawn = true;	
			unit:AddNewModifier(unit, nil, "modifier_fullness", {duration = 120})
			unit:AddNewModifier(unit, nil, "modifier_peppy", {duration = 230})
			unit:SetGold(0,false)
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_bat")
			end	
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_shotgun")
			end
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_shotgun_ammo")
			end	
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_pistol")
			end
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_pistol_ammo")
			end				
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_food_canned")
			end	
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_food_canned")
			end	
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_food_canned")
			end
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_sleeping_tablet")
			end
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_sleeping_tablet")
			end
			if unit:HasAnyAvailableInventorySpace() then
				unit:AddItemByName("item_employee_card")
			end
			--unit:FindAbilityByName("forward_vision"):SetLevel(1)
			--unit:FindAbilityByName("provision_search"):SetLevel(1)
		end
	end
end

 function test_map:GameRulesStateChange(keys)
	local newState = GameRules:State_Get()

	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then 
		
	end
end

function test_map:OnPlayerGainedLevel(data)
	local hero = PlayerResource:GetSelectedHeroEntity(data.player-1)
	hero:SetAbilityPoints(0)
end

function test_map:OnSomeHeroKilled(data)
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

function test_map:OnEntityKilled(data)
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
			--GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end

	end	
end



function test_map:RollDrops(unit)
    local DropInfo = GameRules.DropTable[unit:GetUnitName()]
    if DropInfo then
        for item_name,chance in pairs(DropInfo) do
            if RollPercentage(chance) then
                -- Create the item
                local item = CreateItem(item_name, nil, nil)
                local pos = unit:GetAbsOrigin()
                local drop = CreateItemOnPositionSync( pos, item )
                local pos_launch = pos+RandomVector(RandomFloat(50,50))
                item:LaunchLoot(false, 200, 0.75, pos_launch)
            end
        end
    end
end 

function test_map:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(200))
end  


function test_map:FocusCameraOnPlayer(player)
	PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CameraThink_%d", player:GetPlayerOwnerID()), 
	function()
		PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)	
	return nil
	end,
	1)
end