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
	if IsServer() then
		if self:GetParent():GetHealth() <= 1 then
			self:GetParent():ForceKill(true)
		end
	end
		return -3.5
end


function modifier_heat:RemoveOnDeath()
	return false
end