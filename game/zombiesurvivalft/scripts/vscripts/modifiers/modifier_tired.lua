modifier_tired = class({})


function modifier_tired:IsHidden()
	return false
end


function modifier_tired:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end


function modifier_tired:GetTexture()
    return "custom_folder/modifier_tired"
end


function modifier_tired:OnCreated( data )
	if IsServer() then
		local caster = self:GetParent()
		caster.peppy_count = 1
	end
end


function modifier_tired:GetModifierConstantManaRegen()
		return 0
end


function modifier_tired:RemoveOnDeath()
	return false
end