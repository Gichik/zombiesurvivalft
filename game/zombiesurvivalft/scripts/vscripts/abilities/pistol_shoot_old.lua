pistol_shoot = class({})
endunit = nil

function pistol_shoot:OnSpellStart()
	--print("OnSpellStart")
	local point = self:GetCursorPosition()
	local point2 =  self:GetCursorPosition() - self:GetCaster():GetAbsOrigin()
	point2 = point2*5
	point = point+point2
	endunit = CreateUnitByName("end_shoot", point, true, nil, nil, DOTA_TEAM_NEUTRALS ) 
	endunit:SetHullRadius(0.0)
	
	local info = {
			EffectName = "particles/units/heroes/hero_lina/lina_base_attack.vpcf",
			Ability = self,
			iMoveSpeed = 2500,
			Source = self:GetCaster(),
			Target = endunit,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
		}

	ProjectileManager:CreateTrackingProjectile( info )
	StartSoundEvent("Hero_Sniper.attack", self:GetCaster())
	self:GetCaster():Stop()	

end

function pistol_shoot:OnProjectileThink(vLocation)


	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, self:GetCaster(), 50,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then  --DAMAGE UNIT
		--print("yes")
		StartSoundEvent("Hero_Sniper.AssassinateDamage", units[ 1 ])
		local damage = {
			victim = units[ 1 ],
			attacker = self:GetCaster(),
			damage = 20,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = this,
		}
		ApplyDamage( damage )
		
		if units[ 1 ]:GetUnitName() == "fat_zombie" or units[ 1 ]:GetUnitName() == "zombie" or units[ 1 ]:GetUnitName() == "half_zombie" or units[ 1 ]:GetUnitName() == "fast_zombie" or units[ 1 ]:GetUnitName() == "npc_dota_hero_undying" then
			local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", PATTACH_ABSORIGIN, units[ 1 ])			
			Timers:CreateTimer(2,function()
				ParticleManager:DestroyParticle(id1, false)
				return nil
			end)
		else		
			local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
		end		
			
		if endunit ~= nil then
			endunit:SetAbsOrigin(vLocation)
			FindClearSpaceForUnit(endunit, vLocation, false)
		end
	end

end
--------------------------------------------------------------------------------

function pistol_shoot:OnProjectileHit( hTarget, vLocation )

		Timers:CreateTimer(0.2,function()
		UTIL_Remove(hTarget)
		end)
	return true
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------