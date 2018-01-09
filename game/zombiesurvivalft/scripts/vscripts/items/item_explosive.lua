
if item_explosive == nil then
	item_explosive = class({})
end

function item_explosive:CastFilterResultTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return UF_FAIL_CUSTOM
		end

		if hTarget:IsRealHero() then
			return UF_FAIL_CUSTOM
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_car_door"  then
			return UF_FAIL_CUSTOM
		end	

		return UF_SUCCESS
	end
end


function item_explosive:GetCustomCastErrorTarget(hTarget)
	--print("Error")
	if IsServer() then

		if hTarget == self:GetCaster() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget:IsRealHero() then
			return "#dota_hud_error_bad_target"
		end

		if hTarget and hTarget:GetUnitName() ~= "npc_car_door"  then
			return "#dota_hud_error_bad_target"
		end	

		return UF_SUCCESS
	end
end

function item_explosive:OnSpellStart()
	--print("OnSpellStart")
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hItem = self
	local itemName = self:GetAbilityName()
	local newItem = nil

	hTarget:EmitSound("Item.DropWorld")
	if hTarget:GetUnitName() == "npc_car_door" then
		--hTarget:Kill()
		hTarget:ForceKill(false)
		hTarget:AddNoDraw()
		hCaster:RemoveItem(hItem)
	end

end


