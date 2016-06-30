function Respawn(data)
--	print("Respawn")


	local moob = data.caster
	local name = moob:GetUnitName()

	local zombie = {}
	zombie["fat_zombie_one"] = 0
	zombie["fat_zombie_two"] = 1
	zombie["fat_zombie_three"] = 2
	zombie["fat_zombie_four"] = 3
	zombie["fat_zombie_five"] = 4

	local point = {}
	point[1] = Vector(831,406,160)
	point[2] = Vector(7490,-4480,160)
	point[3] = Vector(-1796,-7708,160)
	point[4] = Vector(-7514,-2396,160)

	local id = zombie[name]

	GameRules:GetGameModeEntity():SetContextThink(string.format("CrystalStatueThink_%d",moob:GetEntityIndex()), 
		function()
		local unit = CreateUnitByName(name, point[RandomInt(1,4)], true, nil, nil, DOTA_TEAM_BADGUYS ) 
		local owner =  PlayerResource:GetPlayer(id)
		unit:SetOwner(owner)
		unit:SetControllableByPlayer(id, true )
		return nil
		end,
		20)
	
end
