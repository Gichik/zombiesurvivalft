modifier_peppy = class({})

LinkLuaModifier("modifier_tired", "modifiers/modifier_tired.lua", LUA_MODIFIER_MOTION_NONE )

function modifier_peppy:IsHidden()
	return false
end


function modifier_peppy:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end


function modifier_peppy:GetTexture()
    return "custom_folder/modifier_peppy"
end


function modifier_peppy:OnCreated( data )
	if IsServer() then
		local caster = self:GetParent()
		caster.peppy_count = 1
	end
end


function modifier_peppy:OnRefresh( data )
	if IsServer() then
		local caster = self:GetParent()
		if not caster.peppy_count then
			caster.peppy_count = 1
		else
			caster.peppy_count = caster.peppy_count + 1
			if caster.peppy_count == 4 then
				AddPeppyAbility("running_man",caster)
			end						
		end
	end
end


function modifier_peppy:GetModifierConstantManaRegen()
		return 3
end

function modifier_peppy:OnDestroy()
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_tired", {})
	end
end

function modifier_peppy:RemoveOnDeath()
	return false
end


function AddPeppyAbility(name,caster)
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