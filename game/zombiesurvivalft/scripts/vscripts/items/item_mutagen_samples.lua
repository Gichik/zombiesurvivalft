
if item_mutagen_samples == nil then
	item_mutagen_samples = class({})
end


LinkLuaModifier("modifier_science_progress", "modifiers/modifier_science_progress.lua", LUA_MODIFIER_MOTION_NONE )

function item_mutagen_samples:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_scientific_table"  then
			return UF_FAIL_CUSTOM
		end		

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return UF_FAIL_CUSTOM
		end		

		return UF_SUCCESS
	end
end


function item_mutagen_samples:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_scientific_table"  then
			return "#dota_hud_error_bad_target"
		end	

		if self:GetCurrentCharges() < self:GetInitialCharges() then
			return "#dota_hud_error_havent_charges"
		end		

		return UF_SUCCESS
	end
end

function item_mutagen_samples:OnSpellStart()
	--print("OnSpellStart")
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hItem = self
	local itemName = self:GetAbilityName()
	local newItem = nil

	hTarget:EmitSound("Item.DropWorld")
	if hTarget:GetUnitName() == "npc_scientific_table" then

		if hItem:GetCurrentCharges() <= hItem:GetInitialCharges() then
			hCaster:RemoveItem(hItem)
		else
			hItem:SetCurrentCharges(hItem:GetCurrentCharges() - hItem:GetInitialCharges())
		end

		if hTarget:HasModifier("modifier_science_progress") then
			local modifier = hTarget:FindModifierByName("modifier_science_progress")
			modifier:SetStackCount(modifier:GetStackCount() + 10)
			if modifier:GetStackCount() >= 100 then
				GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
			end
		else
			hTarget:AddNewModifier(hTarget, nil, "modifier_science_progress", {}):SetStackCount(10)
		end
		
	end
end


