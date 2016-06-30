katana_fury = class({})
LinkLuaModifier( "modifier_slow_moved","modifiers/modifier_slow_moved.lua", LUA_MODIFIER_MOTION_NONE )
first = 0
--print("katana_fury ")
function katana_fury :OnSpellStart()

	local caster = self:GetCaster()
	local count = 25
	
	local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_e.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
	local id2 = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_c.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

	StartSoundEvent("Hero_Juggernaut.BladeFuryStart", self:GetCaster())
	Timers:CreateTimer(5,function()
	ParticleManager:DestroyParticle(id1, false)
	ParticleManager:DestroyParticle(id2, false)
	return nil
	end)

	Timers:CreateTimer(function()
	local point = caster:GetAbsOrigin()		
	vDirection = point
	vDirection = Vector(vDirection.x, vDirection.y, 0) --"particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_blur.vpcf"
	vDirection = vDirection:Normalized()
		
	local info = {
		EffectName	= "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_e.vpcf",
		Ability = self,
		Source = caster,
		vSpawnOrigin = caster:GetAbsOrigin(),
		vVelocity = vDirection * 900 * 0.7, -- EFFECT TRAVELS TOO FUCKING FAST
		fStartRadius = 100,
		fEndRadius = 500,
		fDistance = 100,
		Source = caster,
		iUnitTargetTeams = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetTypes = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iVisionTeamNumber = caster:GetTeamNumber(),
		iVisionRadius = 300
	}	
	first = 0
	ProjectileManager:CreateLinearProjectile( info )
	if count == 0 then
		StopSoundEvent("Hero_Juggernaut.BladeFuryStart", caster)
		return nil
	else
		count = count - 1
		return 0.2
	end
	
	end)


end

function katana_fury :OnProjectileThink(vLocation)

	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, self:GetCaster(), 300,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then  --DAMAGE UNIT
		if first == 0 then
		StartSoundEvent("DOTA_Item.Maim", units[ 1 ])
		
		if units[ 1 ]:GetUnitName() == "fat_zombie" or units[ 1 ]:GetUnitName() == "zombie" or units[ 1 ]:GetUnitName() == "half_zombie" or units[ 1 ]:GetUnitName() == "fast_zombie" or units[ 1 ]:GetUnitName() == "npc_dota_hero_undying" then
			local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_life_stealer/life_stealer_infest_emerge_blood04.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
			local id2 = ParticleManager:CreateParticle("particles/items2_fx/soul_ring_blood.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
			
			Timers:CreateTimer(2,function()
				ParticleManager:DestroyParticle(id1, false)
				ParticleManager:DestroyParticle(id2, false)
				return nil
			end)
		else		
			local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
		end
		end
		local damage = {
			victim = units[ 1 ],
			attacker = self:GetCaster(),
			damage = 5,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = this,
		}
		ApplyDamage( damage )
		units[ 1 ]:AddNewModifier(self:GetCaster(), self, "modifier_slow_moved", { duration = 1 } )
		first = 1

	end

end

