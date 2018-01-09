if main == nil then
	_G.main = class({})
end	

biome_number = RandomInt(1,3)


LinkLuaModifier("modifier_fullness", "modifiers/modifier_fullness.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_peppy", "modifiers/modifier_peppy.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_cold", "modifiers/modifier_cold.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_heat", "modifiers/modifier_heat.lua", LUA_MODIFIER_MOTION_NONE )

function main:InitGameMode()
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

	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(main, "OnSomeHeroKilled"), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(main, "OnEntityKilled"), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main, 'GameRulesStateChange'), self)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main, 'OnPlayerGainedLevel'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(main, 'OnNPCSpawn'), self)

	AddFOWViewer( DOTA_TEAM_NEUTRALS, Vector(0,0,0), 10000, -1, false)
	--AddFOWViewer( DOTA_TEAM_BADGUYS, Vector(0,0,0), 10000, -1, false)
end

function main:OnNPCSpawn(data)
	local unit = EntIndexToHScript(data.entindex)
	if unit:IsHero() then
		if not unit.next_spawn then
			unit.next_spawn = true;	
			unit:AddNewModifier(unit, nil, "modifier_fullness", {duration = 120})
			unit:AddNewModifier(unit, nil, "modifier_peppy", {duration = 230})
			unit:SetGold(0,false)
			
			if biome_number == 1 then
				--main:MoveHeroToBiom(unit,"city")
			end
			if biome_number == 2 then
				unit:AddNewModifier(unit, nil, "modifier_cold", {}) 
				--main:MoveHeroToBiom(unit,"snow")
			end
			if biome_number == 3 then
				unit:AddNewModifier(unit, nil, "modifier_heat", {})
				--main:MoveHeroToBiom(unit,"desert")
			end										
		end
	end
end

 function main:GameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_HERO_SELECTION then
		EmitGlobalSound("ZombieSurvivalFT.IntroStart")
	end

	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then 
		main:AddStartItemToPlayer()
		main:BiomSpawnSettings()

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
			1)
	end
end

function main:OnPlayerGainedLevel(data)
	local hero = PlayerResource:GetSelectedHeroEntity(data.player-1)
	hero:SetAbilityPoints(0)
end

function main:OnSomeHeroKilled(data)
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

function main:OnEntityKilled(data)
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
end



function main:RollDrops(unit)
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

function main:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end  


function main:BiomSpawnSettings()
	--print("BiomSpawnSettings")
	local biomName = "city"
	local foodSPointNum = 0
	local tabletSPointNum = 0
	local ammoSPointNum = 0
	local weaponSPointNum = 0
	local bookSPointNum = 0
	local zombieSPointNum = 0

	if biome_number == 1 then
		biomName = "city"
		foodSPointNum = 17
		tabletSPointNum = 15
		ammoSPointNum = 15
		weaponSPointNum = 10
		bookSPointNum = 8
		woodSPointNum = 15
		zombieSPointNum = 53
	end	

	if biome_number == 2 then
		biomName = "snow"
		foodSPointNum = 11
		tabletSPointNum = 11
		ammoSPointNum = 13
		weaponSPointNum = 6
		bookSPointNum = 5
		woodSPointNum = 10		
		zombieSPointNum = 30
		main:BiomItemSpawn("" .. biomName .. "_paper_spawn_","item_camp_misc", 7, 7)
	end	

	if biome_number == 3 then
		biomName = "desert"
		foodSPointNum = 11
		tabletSPointNum = 11
		ammoSPointNum = 14
		weaponSPointNum = 8
		bookSPointNum = 5
		woodSPointNum = 10		
		zombieSPointNum = 30
	end		

	main:BiomItemSpawn("" .. biomName .. "_food_spawn_","item_food_canned", foodSPointNum, 15)
	main:BiomItemSpawn("" .. biomName .. "_tablet_spawn_","item_sleeping_tablet", tabletSPointNum, 8)
	main:BiomItemSpawn("" .. biomName .. "_tablet_spawn_","item_medical_bandage", tabletSPointNum, 8)	
	main:BiomItemSpawn("" .. biomName .. "_ammo_spawn_","item_pistol_ammo", ammoSPointNum, 15)
	main:BiomItemSpawn("" .. biomName .. "_ammo_spawn_","item_shotgun_ammo", ammoSPointNum, 15)
	main:BiomItemSpawn("" .. biomName .. "_book_spawn_","item_book_of_food", bookSPointNum, 1)
	main:BiomItemSpawn("" .. biomName .. "_wood_spawn_","item_wood_wall", woodSPointNum, 10)
	main:BiomWeaponSpawn("" .. biomName .. "_weapon_spawn_", weaponSPointNum, 2)

	main:BiomZombieSpawn("" .. biomName .. "_zombie_spawn_","npc_zombie", zombieSPointNum, 30)

	GameRules:GetGameModeEntity():SetContextThink(string.format("ZombieSpawnThink_%d",1), 
		function()
			main:BiomZombieSpawn("" .. biomName .. "_zombie_spawn_","npc_zombie", zombieSPointNum, 30)
		end,
		240)
--240 720
	GameRules:GetGameModeEntity():SetContextThink(string.format("ZombieSpawnThink_%d",2), 
		function()
			main:BiomZombieSpawn("" .. biomName .. "_zombie_spawn_","npc_mutant", zombieSPointNum, 20)
		end,
		720)	
end

function main:BiomItemSpawn(pointNamePrefix, itemName, spawnPointNumber, balanceNumber)
	--print("BiomItemSpawn")
	local playerNumber = PlayerResource:GetTeamPlayerCount()

	for l = 1, playerNumber do 
		local spawnPointNameTable = {}

		for i = 1, spawnPointNumber do
			local name = "" .. pointNamePrefix .. i
			table.insert(spawnPointNameTable,name)
		end

		for i = 1, balanceNumber do
			if #spawnPointNameTable > 0 then
				local number = RandomInt(1,#spawnPointNameTable)
				local point = Entities:FindByName(nil,spawnPointNameTable[number]):GetAbsOrigin()
				table.remove(spawnPointNameTable, number)

				local newItem = CreateItem(itemName, nil, nil)
				local drop = CreateItemOnPositionSync(point + RandomVector(RandomFloat(1,50)),newItem)

			    if drop then
		            drop:SetContainedItem( newItem )
		        end
		    end
		end
	end
end


function main:BiomWeaponSpawn(pointNamePrefix, spawnPointNumber, balanceNumber)

	local playerNumber = PlayerResource:GetTeamPlayerCount()

	for l = 1, playerNumber do 
		local spawnPointNameTable = {}

		for i = 1, spawnPointNumber do
			local name = "" .. pointNamePrefix .. i
			table.insert(spawnPointNameTable,name)
		end

		for i = 1, balanceNumber do
			if #spawnPointNameTable > 0 then
				local number = RandomInt(1,#spawnPointNameTable)
				local point = Entities:FindByName(nil,spawnPointNameTable[number]):GetAbsOrigin()
				table.remove(spawnPointNameTable, number)

				local itemName = TABLE_WEAPON[RandomInt(1,#TABLE_WEAPON)] 
				local newItem = CreateItem(itemName, nil, nil)
				local drop = CreateItemOnPositionSync(point + RandomVector(RandomFloat(1,50)),newItem)

			    if drop then
		            drop:SetContainedItem( newItem )
		        end
		    end
		end
	end
end

function main:BiomZombieSpawn(pointNamePrefix, zombieName, spawnPointNumber, balanceNumber)
	--print("BiomItemSpawn")

	local spawnPointNameTable = {}

	for i = 1, spawnPointNumber do
		local name = "" .. pointNamePrefix .. i
		table.insert(spawnPointNameTable,name)
	end

	for i = 1, balanceNumber do
		if #spawnPointNameTable > 0 then
			local number = RandomInt(1,#spawnPointNameTable)
			local point = Entities:FindByName(nil,spawnPointNameTable[number]):GetAbsOrigin()
			table.remove(spawnPointNameTable, number)
			local unit = CreateUnitByName(zombieName, point, true, nil, nil, DOTA_TEAM_NEUTRALS )
			unit.vSpawnLoc = point
			unit.vSpawnVector = RandomVector(RandomFloat(1, 360))	
	    end
	end

end

function main:MoveHeroToBiom(unit,biomName)
	if #TABLE_HEROES_SPAWN ~= 0 then
		local numberSpawn = RandomInt(1,#TABLE_HEROES_SPAWN)
		local point = Entities:FindByName(nil,"" .. biomName .. TABLE_HEROES_SPAWN[numberSpawn]):GetAbsOrigin() 
		table.remove(TABLE_HEROES_SPAWN, numberSpawn)

		GameRules:GetGameModeEntity():SetContextThink(string.format("HeroesMoveThink_%d", unit:GetPlayerOwnerID()), 
		function()
			unit:SetAbsOrigin(point) 
			FindClearSpaceForUnit(unit, point, false) 
			unit:Stop()
			main:FocusCameraOnPlayer(unit)			
		return nil
		end,
		1)	
	end
end

function main:FocusCameraOnPlayer(player)
	PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(),player)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CameraThink_%d", player:GetPlayerOwnerID()), 
	function()
		PlayerResource:SetCameraTarget(player:GetPlayerOwnerID(), nil)	
	return nil
	end,
	1)
end

function main:AddStartItemToPlayer()
	for i = 0, PlayerResource:GetPlayerCount()-1 do
		local hero = PlayerResource:GetSelectedHeroEntity(i)
		if hero then
			for j = 0, 8 do
				local item = hero:GetItemInSlot(j)
				if item then
					hero:RemoveItem(item)
				end
			end	

			if hero:HasAnyAvailableInventorySpace() then
				hero:AddItemByName("item_bat")
			end	
		end
	end
end