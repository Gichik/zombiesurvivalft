
if item_employee_card == nil then
	item_employee_card = class({})
end

function item_employee_card:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end
--[[
		if not hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end]]

		return UF_SUCCESS
	end
end


function item_employee_card:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		--[[
		if not hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end]]

		return UF_SUCCESS
	end
end

function item_employee_card:OnSpellStart()
	--print("OnSpellStart")
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hItem = self
	local itemName = self:GetAbilityName()
	local newItem = nil

	hTarget:EmitSound("Item.DropWorld")
	if hTarget:GetUnitName() == "npc_military_door" then
		--hTarget:Kill()
		hTarget:ForceKill(false)
		hTarget:AddNoDraw()
		hCaster:RemoveItem(hItem)
	end

end


