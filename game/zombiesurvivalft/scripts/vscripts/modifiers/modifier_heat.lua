modifier_heat = class({})


function modifier_heat:IsHidden()
	return false
end


function modifier_heat:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end


function modifier_heat:GetTexture()
	--[[if IsServer() then
		local texture = "custom_folder/modifier_heat"
		if not GameRules:IsDaytime() then
			texture = "custom_folder/modifier_cool"
		end
		return texture
	end]]

	return "custom_folder/modifier_heat"
end

function modifier_heat:GetModifierConstantHealthRegen()
	if self:GetParent():GetHealth() <= 1 then
		self:GetParent():ForceKill(true)
	end
		return -3
end


function modifier_heat:RemoveOnDeath()
	return false
end