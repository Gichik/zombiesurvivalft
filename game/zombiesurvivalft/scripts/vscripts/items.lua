
function RemoveItemFromHero(data)
	local caster = data.caster
	local item = nil
	local charges = 0
	for i = 0, 5 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == data.item_name then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
						return nil
					else
						caster:RemoveItem(item)
						return nil
					end
				else
					caster:RemoveItem(item)	
					return nil		
				end
			end
		end
	end	
end


function CreateDrop (itemName, pos)
   local newItem = CreateItem(itemName, nil, nil)
   newItem:SetPurchaseTime(0)
   CreateItemOnPositionSync(pos, newItem)
   newItem:LaunchLoot(false, 300, 0.75, pos + RandomVector(RandomFloat(50, 350)))
end 


function GiveAbility(data)
	local caster = data.caster
	local name = data.Name

	if caster and name then
		if not caster:FindAbilityByName(name) then
			for i = 0, 12 do
				if not caster:GetAbilityByIndex(i) then
					local ability = caster:AddAbility(name)
					ability:SetLevel(1)
					return nil
				end
			end
		end
	end
end


function CreateWoodWall(data)
	local caster = data.caster	
	local target = data.target	
	local point = target:GetAbsOrigin()

	target:SetHullRadius(50.0)
	target:SetForwardVector(caster:GetForwardVector())

	local units = FindUnitsInRadius( caster:GetTeamNumber(), point, caster, 100,
			DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	for i = 1, #units do		
		if units[ i ] and units[ i ]:GetUnitName() ~= "wood_wall" then 
			FindClearSpaceForUnit(units[ i ],units[ i ]:GetAbsOrigin(),true)
		end
	end
end


function DestroyWoodWall(data)
--print("DestroyWoodWall")
--StartSoundEvent("Hero_Furion.Sprout", data.caster)
	data.caster:ForceKill(false)
end

function RemoveBleeding(data)
	data.caster:RemoveModifierByName("modifier_bleeding")	
end

function ItemsChannelFinish()

print("ItemsChannelFinish")
end


function ItemsChannelSucceeded()

print("ItemsChannelSucceeded")
end

function ItemsChannelInterrupted()

print("ItemsChannelInterrupted")
end