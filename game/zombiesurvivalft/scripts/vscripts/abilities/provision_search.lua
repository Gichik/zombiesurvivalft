PISTOL_DROPS = true
SHOTGUN_DROPS = true

if provision_search == nil then
	provision_search = class({})
end


function provision_search:GetChannelAnimation()
    return ACT_DOTA_ATTACK2
end

function provision_search:GetCastAnimation()
    return ACT_DOTA_ATTACK2
end

function provision_search:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

	end
end

function provision_search:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

	end
end

function provision_search:OnChannelFinish(interrupted)
	if IsServer() then
		if interrupted == false then
			--print("ChannelSucceeded")
			local target = self:GetCursorTarget()
			if target and target:HasAbility("provision_status") then
				CreateProvision(target:GetUnitName(),target:GetAbsOrigin())
				target:ForceKill(false)
				target:AddNoDraw()
			end

		else
			--print("ChannelInterrupted")
		end
	end
end


function CreateProvision(unitName, point)
	if unitName == "npc_military_box" then
		if RollPercentage(30) and PISTOL_DROPS then
			DropProvision("item_pistol",point)
			PISTOL_DROPS = false
		end
		if RollPercentage(30) and SHOTGUN_DROPS then
			DropProvision("item_shotgun",point)
			SHOTGUN_DROPS = false
		end
		if RollPercentage(60) then
			DropProvision("item_pistol_ammo",point)
		end
		if RollPercentage(60) then
			DropProvision("item_shotgun_ammo",point)
		end
	end
	if unitName == "npc_food_box" then
		if RollPercentage(60) then
			DropProvision("item_food_canned",point)
		end
		if RollPercentage(60) then
			DropProvision("item_sleeping_tablet",point)
		end
		if RollPercentage(30) then
			DropProvision("item_medical_bandage",point)
		end		
	end	
	if unitName == "npc_city_box" then
		if RollPercentage(60) then
			DropProvision("item_wood_wall",point)
		end
		if RollPercentage(10) then
			DropProvision("item_book_of_food",point)
		end
		if RollPercentage(100) then
			DropProvision("item_mutagen_samples",point)
		end
	end	

end


function DropProvision (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(10, 50)))
end