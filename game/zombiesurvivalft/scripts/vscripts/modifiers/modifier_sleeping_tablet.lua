modifier_sleeping_tablet = class({})

LinkLuaModifier("modifier_peppy", "modifiers/modifier_peppy.lua", LUA_MODIFIER_MOTION_NONE )

function modifier_sleeping_tablet:IsHidden()
	return false
end

function modifier_sleeping_tablet:OnCreated(params)
	self.pID = ParticleManager:CreateParticle("particles/generic_gameplay/generic_sleep.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
end


function modifier_sleeping_tablet:CheckState() 
  local state = {
      [MODIFIER_STATE_STUNNED] = true,
  }

  return state
end


function modifier_sleeping_tablet:GetTexture()
    return "custom_folder/modifier_sleeping_tablet"
end


function modifier_sleeping_tablet:OnDestroy()
	if IsServer() then
		self:GetParent():RemoveModifierByName("modifier_tired")
		self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_peppy", {duration = 230})
	end
	ParticleManager:DestroyParticle(self.pID, false)	
end


function modifier_sleeping_tablet:RemoveOnDeath()
	return true
end