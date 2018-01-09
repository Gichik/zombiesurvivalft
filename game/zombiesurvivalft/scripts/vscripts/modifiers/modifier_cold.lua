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
	if IsServer() then
		if self:GetParent():GetHealth() <= 1 then
			self:GetParent():ForceKill(true)
		end
	end
		return -3.5
end


function modifier_cold:RemoveOnDeath()
	return false
end