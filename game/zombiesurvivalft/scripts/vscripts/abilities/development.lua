first = 1
count = 0;

function IncrementingCounter(data)
--print("development")
local hero = data.caster

if hero:FindAbilityByName("knowledge") ~= nil then

	if hero:HasItemInInventory("item_microscope") == true then
		if first == 1 then
			EmitGlobalSound("ZombieSurvivalFT.ZombieAttack")
			first = 0
		end

		local point1 = Entities:FindByName( nil, "point_particle_1")
		local point2 = Entities:FindByName( nil, "point_particle_2")
		local id1 = ParticleManager:CreateParticle("particles/econ/courier/courier_shagbark/courier_shagbark_firefly_big.vpcf", PATTACH_ABSORIGIN_FOLLOW, point1)
		local id2 = ParticleManager:CreateParticle("particles/econ/courier/courier_shagbark/courier_shagbark_firefly_big.vpcf", PATTACH_ABSORIGIN_FOLLOW, point2)
		Timers:CreateTimer(3,function()
		ParticleManager:DestroyParticle(id1, false)
		ParticleManager:DestroyParticle(id2, false)
		return nil
		end)
		
		SpawnMoobs()
		
		if count >= 90 then
			Say(nil,"Progress: 100%", false)
			Say(nil,"You do it", false)		
			CreateDrop("item_recipe_antidote", hero:GetAbsOrigin())
			count = 0
		else
			count = count + 10;
			Say(nil,"Progress: " .. count .. "%", false)
		end	
	else
		Say(nil,"You have not microscope", false)
	end
else
	Say(nil,"You need knowledge for this", false)
end

end


function CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end 


function SpawnMoobs()
local point = nil
local unit = nil
local ability = nil
local way = nil
local i = 0

	point = Entities:FindByName( nil, "spawn_202"):GetAbsOrigin()
	unit = CreateUnitByName("fat_zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	unit:RemoveAbility("respawn")
	way = Entities:FindByName( nil, "way_202") 
	unit:SetInitialGoalEntity( way )	
	
	point = Entities:FindByName( nil, "spawn_203"):GetAbsOrigin()
	unit = CreateUnitByName("fat_zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	unit:RemoveAbility("respawn")
	way = Entities:FindByName( nil, "way_203") 
	unit:SetInitialGoalEntity( way )	

for i = 1, 2 do
	point = Entities:FindByName( nil, "spawn_201"):GetAbsOrigin()
	unit = CreateUnitByName("zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	unit:RemoveAbility("respawn")
	way = Entities:FindByName( nil, "way_201") 
	unit:SetInitialGoalEntity( way )	
	
	point = Entities:FindByName( nil, "spawn_202"):GetAbsOrigin()
	unit = CreateUnitByName("zombie", point, true, nil, nil, DOTA_TEAM_BADGUYS ) 
	unit:RemoveAbility("respawn")
	way = Entities:FindByName( nil, "way_202") 
	unit:SetInitialGoalEntity( way )
	
end	
	
end