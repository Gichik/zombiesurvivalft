modifier_cold = class({})


function modifier_cold:IsHidden()
	return false
end


function modifier_cold:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end


function modifier_cold:GetTexture()
    return "custom_folder/modifier_cold"
end

function modifier_cold:GetModifierConstantHealthRegen()
	if self:GetParent():GetHealth() <= 1 then
		self:GetParent():ForceKill(true)
	end
		return -3
end


function modifier_cold:RemoveOnDeath()
	return false
end