shotgun_shoot = class({})
first = 0
--XCaster = nil
function shotgun_shoot:OnSpellStart()
	--print("shotgun_shoot OnSpellStart")
	local caster = self:GetCaster()
	local point = self:GetCaster():GetAbsOrigin() + (self:GetCaster():GetForwardVector() * 200)	
	
	vDirection = point - caster:GetAbsOrigin()
	vDirection = Vector(vDirection.x, vDirection.y, 0) --LIMIT MOTION TO ONLY ONE PLANE
	vDirection = vDirection:Normalized()
	
	local id1 = ParticleManager:CreateParticle("particles/econ/events/league_teleport_2014/teleport_end_dust_league.vpcf", PATTACH_ABSORIGIN, caster)

	Timers:CreateTimer(3,function()
		ParticleManager:DestroyParticle(id1, false)
		return nil
	end)	
	
	local info = {
		EffectName	= "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf",
		Ability = self,
		Source = caster,
		vSpawnOrigin = caster:GetAbsOrigin(),
		vVelocity = vDirection * 3000 * 0.7, -- EFFECT TRAVELS TOO FUCKING FAST
		fStartRadius = 70,
		fEndRadius = 100,
		fDistance = 300,
		Source = caster,
		iUnitTargetTeams = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetTypes = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iVisionTeamNumber = caster:GetTeamNumber(),
		iVisionRadius = 65
	}
	first = 0
	ProjectileManager:CreateLinearProjectile( info )
	StartSoundEvent("Hero_Sniper.MKG_attack", self:GetCaster())
	self:GetCaster():Stop()	

end

function shotgun_shoot:OnProjectileThink(vLocation)

	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, self:GetCaster(), 300,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then  --DAMAGE UNIT
		if first == 0 then
			StartSoundEvent("Hero_Sniper.AssassinateDamage", units[ 1 ])
		end
		local damage = {
			victim = units[ 1 ],
			attacker = self:GetCaster(),
			damage = 30,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = this,
		}
		ApplyDamage( damage )
		knockback(self:GetCaster(),units[ 1 ])
		
		if units[ 1 ]:GetUnitName() == "fat_zombie" or units[ 1 ]:GetUnitName() == "zombie" or units[ 1 ]:GetUnitName() == "half_zombie" or units[ 1 ]:GetUnitName() == "fast_zombie" or units[ 1 ]:GetUnitName() == "npc_dota_hero_undying" then
			local id2 = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodbath_d.vpcf", PATTACH_ABSORIGIN, units[ 1 ])			
			Timers:CreateTimer(1,function()
				ParticleManager:DestroyParticle(id2, false)
				return nil
			end)
		else		
			local id0 = ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
		end			
				
		first = 1

	end

end
--[[
	Author: kritth
	Date: 09.01.2015
	Knockback enemies in the line accordingly to the distance
]]
function knockback( caster, target )


    local duration = 1
    local distance =300
    local height = 0
	local range = 400
	local vTarget = target:GetAbsOrigin()
	
	
	local vCaster = caster:GetAbsOrigin()
	local vTarget = target:GetAbsOrigin()
	local len = ( vTarget - vCaster ):Length2D()
	len = distance - distance * ( len / range )
	local knockbackModifierTable =
	{
		should_stun = 1,
		knockback_duration = duration,
		duration = duration,
		knockback_distance = len,
		knockback_height = 0,
		center_x = caster:GetAbsOrigin().x,
		center_y = caster:GetAbsOrigin().y,
		center_z = caster:GetAbsOrigin().z
	}
	target:AddNewModifier( caster, nil, "modifier_knockback", knockbackModifierTable )

end