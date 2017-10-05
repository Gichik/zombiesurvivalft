
if item_military_cage == nil then
    item_military_cage = class({})
end

function item_military_cage:GetAbilityTextureName(brokenAPI)
  return self.BaseClass.GetAbilityTextureName( self )
end


function item_military_cage:OnAbilityPhaseStart()
	if IsServer() then
		print("OnAbilityPhaseStart")
		local caster = self:GetCaster()
		local ent = Entities:FindInSphere(caster,caster:GetAbsOrigin(),300)
		self.spawnPoint = caster:GetAbsOrigin() + caster:GetForwardVector()*100

		if ent then
			self.spawnPoint = ent:GetAbsOrigin()
		end

		self.pID1 = ParticleManager:CreateParticle("particles/dark_smoke_test.vpcf", PATTACH_CUSTOMORIGIN, nil )
		ParticleManager:SetParticleControl( self.pID1, 0, self.spawnPoint)
	end
	return true
end


function item_military_cage:OnSpellStart()
	if IsServer() then
		--print("OnSpellStart")
	end
end

function item_military_cage:OnChannelFinish(interrupted)
	if IsServer() then
		ParticleManager:DestroyParticle(self.pID1, false)
		if interrupted == false then
			print("ChannelSucceeded")
		else
			print("ChannelInterrupted")
			CreateItemOnPositionSync(self.spawnPoint, self)
		end
	end
end


function item_military_cage:OnAbilityPhaseInterrupted()
	if IsServer() then
		print("OnAbilityPhaseInterrupted")
	end
end