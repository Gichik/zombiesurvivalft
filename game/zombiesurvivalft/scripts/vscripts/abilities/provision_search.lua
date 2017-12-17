
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
			print("ChannelSucceeded")
			local target = self:GetCursorTarget()
			if target and target:HasAbility("provision_status") then
				CreateProvision(target:GetUnitName(),target:GetAbsOrigin())
				target:ForceKill(false)
				target:AddNoDraw()
			end

		else
			print("ChannelInterrupted")
		end
	end
end


function CreateProvision(unitName, point)
	if unitName == "npc_military_box" then
		DropProvision("item_pistol",point)

	end

end


function DropProvision (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   --newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end