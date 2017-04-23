modifier_zombie_movespeed_bonus = class({})


function modifier_zombie_movespeed_bonus:IsHidden()
	return false
end


function modifier_zombie_movespeed_bonus:DeclareFunctions()
	return { MODIFIER_PROPERTY_MANA_REGEN_CONSTANT }
end


function modifier_zombie_movespeed_bonus:GetTexture()
    return "custom_folder/modifier_tired"
end


function modifier_zombie_movespeed_bonus:GetModifierConstantManaRegen()
		return 0
end


function modifier_zombie_movespeed_bonus:RemoveOnDeath()
	return true
end