
if item_pistol_ammo == nil then
	item_pistol_ammo = class({})
end

function item_pistol_ammo:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

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


function item_pistol_ammo:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

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

function item_pistol_ammo:OnSpellStart()
	--print("OnSpellStart")
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hItem = self
	local itemName = self:GetAbilityName()
	local newItem = nil

	hTarget:EmitSound("Item.DropWorld")
    if hTarget:HasItemInInventory(itemName) then
        newItem = FindItemInInventory(hTarget,itemName)
        if newItem then
            newItem:SetCurrentCharges(newItem:GetCurrentCharges() + hItem:GetInitialCharges())
        end
    else
        hTarget:AddItemByName(itemName)
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
