if item_food_canned == nil then
	item_food_canned = class({})
end

LinkLuaModifier("modifier_fullness", "modifiers/modifier_fullness.lua", LUA_MODIFIER_MOTION_NONE )

function item_food_canned:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then
		if not hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if not hTarget:HasItemInInventory(self:GetAbilityName()) then
			if not hTarget:HasAnyAvailableInventorySpace() then
				return UF_FAIL_CUSTOM
			end
		end

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return UF_FAIL_CUSTOM
		end

		return UF_SUCCESS
	end
end


function item_food_canned:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then
		if not hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if not hTarget:HasItemInInventory(self:GetAbilityName()) then
			if not hTarget:HasAnyAvailableInventorySpace() then
				return "#dota_hud_error_full_inventory"
			end
		end

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return "#dota_hud_error_havent_charges"
		end

		return UF_SUCCESS
	end
end

function item_food_canned:OnSpellStart()
	--print("OnSpellStart")
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hItem = self
	local itemName = self:GetAbilityName()
	local newItem = nil
	local time = 160

	if hTarget == hCaster then
		if hCaster:HasAbility("the_right_diet") then
			time = 200
		end

		hCaster:RemoveModifierByName("modifier_hungry")
		hCaster:AddNewModifier(hCaster, nil, "modifier_fullness", {duration = time})
		hCaster:EmitSound("DOTA_Item.Cheese.Activate")
	else
		if hTarget:HasItemInInventory(itemName) then
			newItem = FindItemInInventory(hTarget,itemName)
			if newItem then
				newItem:SetCurrentCharges(newItem:GetCurrentCharges() + hItem:GetInitialCharges())
			end
		else
			hTarget:AddItemByName(itemName)
		end
		hTarget:EmitSound("Item.DropWorld")
	end

	if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
		hCaster:RemoveItem(hItem)
		return
	end

	hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())

end

function FindItemInInventory(hTarget, itemName)
	local item = nil
	for i = 0, 8 do
		item = hTarget:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == itemName then
				return item
			end
		end
	end
	return nil
end
