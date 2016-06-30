PolicemanLock = 1
HospitalLock = 1
LibraryLock = 1
ScienceCenterLock = 1
counterDeathsGG = 0
counterGG = 0

function main:InitGameMode()
	print( "InitGameMode" )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
	
	GameRules:SetTimeOfDay( 0.5 )
	GameRules:SetHeroRespawnEnabled( false )
	GameRules:SetUseUniversalShopMode( false )
	GameRules:SetHeroSelectionTime( 20.0 )
	GameRules:SetPreGameTime( 5.0 )
	GameRules:SetPostGameTime( 60.0 )
	GameRules:SetTreeRegrowTime( 60.0 )
	GameRules:SetHeroMinimapIconScale( 0.7 )
	GameRules:SetCreepMinimapIconScale( 0.7 )
	GameRules:SetRuneMinimapIconScale( 0.7 )
	GameRules:SetGoldTickTime( 60.0 )
	GameRules:SetGoldPerTick( 0 )
	GameRules:GetGameModeEntity():SetRemoveIllusionsOnDeath( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesOverride( true )
	GameRules:GetGameModeEntity():SetTopBarTeamValuesVisible( false )
	GameRules:GetGameModeEntity():SetBuybackEnabled( false )
	GameRules:GetGameModeEntity():SetRecommendedItemsDisabled( true )	

	
	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )
	GameRules:GetGameModeEntity():SetCustomHeroMaxLevel( 1 )
	GameRules.DropTable = LoadKeyValues("scripts/kv/item_drops.kv")

	

	ListenToGameEvent("dota_player_killed", Dynamic_Wrap(main, "OnHeroKilled"), self)
    ListenToGameEvent('entity_killed', Dynamic_Wrap(main, 'OnEntityKilled'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(main, 'GameRulesStateChange'), self)
	ListenToGameEvent("dota_player_gained_level", Dynamic_Wrap(main, 'OnPlayerGainedLevel'), self)
	ListenToGameEvent("npc_spawned", Dynamic_Wrap(main, 'OnNPCSpawn'), self)

	

	main:SpawnMoobs()

	
end

function main:OnNPCSpawn(data)

local player = EntIndexToHScript(data.entindex)

if player:IsHero() then			
	local teamNumb = player:GetTeamNumber()
	local name =  GetTeamName(teamNumb)
	if name == "#DOTA_GoodGuys" then		
		--print("counterGG:")print(counterGG)
		player:SetAbilityPoints(0)		
		for i = 0, 8 do	
			local ability = player:GetAbilityByIndex(i)
			if ability ~= nil then
				if ability:GetLevel() == 0 then							
					  ability:SetLevel(1)
				end
			end
		end
		
		if player:HasAnyAvailableInventorySpace() then
			player:AddItemByName(main:GiveSomeItem())
		end
		
	end
end

end


 function main:GameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then 
		GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 5 )

		--ShowGenericPopup(  "#popup_title_Main", "#popup_body_Main", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
		EmitGlobalSound("ZombieSurvivalFT.ShadowHouse")
		
		Timers:CreateTimer(245,function()
			EmitGlobalSound("ZombieSurvivalFT.Night")
			return 480
		end)	
		Timers:CreateTimer(485,function()
			EmitGlobalSound("ZombieSurvivalFT.Horror")
			return 480
		end)
		
		for i=0,5 do
			if PlayerResource:IsValidPlayer(i) then
				counterGG = counterGG + 1
			end
		end
		
		
		
	end
end


function main:OnPlayerGainedLevel(data)
local hero = PlayerResource:GetSelectedHeroEntity(data.player-1)
hero:SetAbilityPoints(0)
end

function main:ActivatePoliceStation()
PolicemanLock = 0
end

function main:ActivateHospital()
HospitalLock = 0
end

function main:ActivateLibrary()
LibraryLock = 0
end

function main:ActivateScienceCenter()
ScienceCenterLock = 0
end

function main:IncreaseDeathCounter()
	counterDeathsGG = counterDeathsGG + 1
	if counterDeathsGG >= counterGG and PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS) > 0 then
		--ShowGenericPopup(  "#popup_title_end", "#popup_body_end", "", "", DOTA_SHOWGENERICPOPUP_TINT_SCREEN )
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		return true
	end
	return false 	
end

function main:SpawnMoobs()
local point = nil
local unit = nil
local ability = nil
local way = nil
local i = 0

for i = 1, 12 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("trashcan", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
end	
	
for i = 51, 53 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("old_chest", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
end		
	
	
for i = 60, 60 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("safe", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
end		
	
for i = 71, 78 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("shelf", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
end	

for i = 81, 84 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("bottles", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
end	

for i = 91, 98 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("chest", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
end	

for i = 101, 180 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName(main:GiveNameOfZombie(), point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	ability = unit:FindAbilityByName("respawn")
	ability:SetOverrideCastPoint(i)
	way = Entities:FindByName( nil, "way_" .. i) 
	unit:SetInitialGoalEntity( way )		
end	


for i = 301, 314 do
	point = Entities:FindByName( nil, "spawn_" .. i):GetAbsOrigin()
	unit = CreateUnitByName("radiation_source", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 	
end	

	
end



 function main:OnEntityKilled (data)
    local killedUnit = EntIndexToHScript( data.entindex_killed )
    if killedUnit:IsNeutralUnitType() or killedUnit:IsCreature() then
        main:RollDrops(killedUnit)
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


function main:OnHeroKilled(data)
--	print("hero killed")
	local killedEntity = PlayerResource:GetSelectedHeroEntity(data.PlayerID)
	if killedEntity:GetNumItemsInInventory() ~=0 then
	   for i=0,5 do
			local item = killedEntity:GetItemInSlot(i);
			if item ~= nil then
				local position = killedEntity:GetAbsOrigin()
				local name = item:GetAbilityName()
				killedEntity:RemoveItem(item)		
				main:CreateDrop(name, position)
			end
		end
   end
   
--[[   
   local killedPlayer = PlayerResource:GetPlayer(data.PlayerID)	
	local number = killedPlayer:GetTeamNumber()
	local name =  GetTeamName(number)
	
	if name == "#DOTA_GoodGuys" then
		counterDeathsGG = counterDeathsGG + 1
	end
   
	if counterDeathsGG >= counterGG and PlayerResource:GetPlayerCountForTeam(DOTA_TEAM_GOODGUYS) > 0 then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
	end
 ]]  
 
end

 function main:CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
 end  
 
 
 function main:GiveNameOfZombie()
 
 local number = RandomInt(1, 4)
 
if number == 1 then
	return "fat_zombie"
elseif number == 2 then
	return "zombie"
elseif number == 3 then
	return "half_zombie"
else
	return "fast_zombie"
end

 end
 
 function main:GiveSomeItem()
  local number = RandomInt(1, 3)
 
if number == 1 then
	return "item_pistol"
elseif number == 2 then
	return "item_food_canned"
else 
	return "item_bat"
end
 end