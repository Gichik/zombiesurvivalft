modifier_hungry = class({})


function modifier_hungry:IsHidden()
	return false
end


function modifier_hungry:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end


function modifier_hungry:GetTexture()
    return "custom_folder/modifier_hungry"
end

function modifier_hungry:OnCreated( data )
	if IsServer() then
		local caster = self:GetParent()
		caster.fullness_count = 1
	end
end


function modifier_hungry:GetModifierConstantHealthRegen()
	if IsServer() then
		if self:GetParent():GetHealth() <= 1 then
			self:GetParent():ForceKill(true)
		end
	end
		return -0.5
end


function modifier_hungry:RemoveOnDeath()
	return false
end