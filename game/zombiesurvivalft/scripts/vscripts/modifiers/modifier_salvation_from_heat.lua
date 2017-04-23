modifier_fullness = class({})

LinkLuaModifier("modifier_heat", "modifiers/modifier_heat.lua", LUA_MODIFIER_MOTION_NONE )

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
	self:GetParent():RemoveModifierByName("modifier_heat")	
end

function modifier_fullness:GetModifierConstantHealthRegen()
		return 0
end


function modifier_fullness:OnDestroy()
	if IsServer() then
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_heat", {})
	end
end

function modifier_fullness:RemoveOnDeath()
	return false
end

