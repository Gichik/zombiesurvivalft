function Transformation(data)
	--print("Transformation")
	if main:IncreaseDeathCounter() == false then
		local player = data.caster:GetPlayerOwner()
		if player then 
			local ID = data.caster:GetPlayerOwnerID()	

			local hero = player:GetAssignedHero()
			local zombie = {}
			zombie[0] = "fat_zombie_one"
			zombie[1] = "fat_zombie_two"
			zombie[2] = "fat_zombie_three"
			zombie[3] = "fat_zombie_four"
			zombie[4] = "fat_zombie_five"

			local point = {}
			point[1] = Vector(831,406,160)
			point[2] = Vector(7490,-4480,160)
			point[3] = Vector(-1796,-7708,160)
			point[4] = Vector(-7514,-2396,160)

			player:SetTeam(DOTA_TEAM_BADGUYS)
			hero:SetTeam(DOTA_TEAM_BADGUYS)	
			local unit = CreateUnitByName(zombie[ID], point[RandomInt(1,4)], true, nil, nil, DOTA_TEAM_BADGUYS ) 
			unit:SetOwner(player)
			unit:SetControllableByPlayer( ID, true )
			FocusCameraOnUnit(ID,unit)
		end
	end
end


function FocusCameraOnUnit(playerID,unit)
	PlayerResource:SetCameraTarget(playerID,unit)
	GameRules:GetGameModeEntity():SetContextThink(string.format("CreatureThink_%d", playerID), 
	function()
		PlayerResource:SetCameraTarget(playerID, nil)	
	return nil
	end,
	1)
end