modifier_cool = class({})


function modifier_cool:IsHidden()
	return false
end


function modifier_cool:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end


function modifier_cool:GetTexture()
    return "custom_folder/modifier_cool"
end

function modifier_cool:GetModifierConstantHealthRegen()
	return 3
end


function modifier_cool:RemoveOnDeath()
	return true
end