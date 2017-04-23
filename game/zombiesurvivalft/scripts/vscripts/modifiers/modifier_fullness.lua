modifier_fullness = class({})

LinkLuaModifier("modifier_hungry", "modifiers/modifier_hungry.lua", LUA_MODIFIER_MOTION_NONE )

function modifier_fullness:IsHidden()
	return false
end


function modifier_fullness:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end


function modifier_fullness:GetTexture()
    return "custom_folder/modifier_fullness"
end


function modifier_fullness:OnCreated( data )
	if IsServer() then
		local caster = self:GetParent()
		caster.fullness_count = 1
	end
end


function modifier_fullness:OnRefresh( data )
	if IsServer() then
		local caster = self:GetParent()
		if not caster.fullness_count then
			caster.fullness_count = 1
		else
			caster.fullness_count = caster.fullness_count + 1
			if caster.fullness_count == 4 then
				AddFullnessAbility("wellness_man",caster)
			end			
		end
	end
end


function modifier_fullness:GetModifierConstantHealthRegen()
		return 3
end


function modifier_fullness:OnDestroy()
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_hungry", {})
	end
end

function modifier_fullness:RemoveOnDeath()
	return false
end

function AddFullnessAbility(name,caster)
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


--function modifier_fullness:IsDebuff()
--		return false
--end