blow_bat = class({})
first = 0
--XCaster = nil
function blow_bat:OnSpellStart()
	--print("blow_bat OnSpellStart")
	local caster = self:GetCaster()
	local point = self:GetCaster():GetAbsOrigin() + (self:GetCaster():GetForwardVector() * 200)	
	
	vDirection = point - caster:GetAbsOrigin()
	vDirection = Vector(vDirection.x, vDirection.y, 0) 
	vDirection = vDirection:Normalized()
	local id1 = ParticleManager:CreateParticle("particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(id1, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControlForward(id1, 0, caster:GetForwardVector()*(-1))
	
		Timers:CreateTimer(1,function()
	ParticleManager:DestroyParticle(id1, false)
	return nil
	end)
	
	
	
	local info = {
		EffectName	= "particles/units/heroes/hero_beastmaster/beastmaster_wildaxe_dust_swirl.vpcf",
		Ability = self,
		Source = caster,
		vSpawnOrigin = caster:GetAbsOrigin(),
		vVelocity = vDirection * 900 * 0.7, 
		fStartRadius = 70,
		fEndRadius = 70,
		fDistance = 250,
		Source = caster,
		iUnitTargetTeams = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetTypes = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iVisionTeamNumber = caster:GetTeamNumber(),
		iVisionRadius = 65
	}
	first = 0
	ProjectileManager:CreateLinearProjectile( info )
	StartSoundEvent("Hero_Axe.CounterHelix", self:GetCaster())
	self:GetCaster():Stop()	

end

function blow_bat:OnProjectileThink(vLocation)

	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, self:GetCaster(), 100,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		
	if units[ 1 ] then  --DAMAGE UNIT
		if first == 0 then
			StartSoundEvent("Hero_Spirit_Breaker.GreaterBash", units[ 1 ])
			if units[ 1 ]:GetUnitName() == "fat_zombie" or units[ 1 ]:GetUnitName() == "zombie" or units[ 1 ]:GetUnitName() == "half_zombie" or units[ 1 ]:GetUnitName() == "fast_zombie" or units[ 1 ]:GetUnitName() == "npc_dota_hero_undying" then
				local id2 = ParticleManager:CreateParticle("particles/generic_gameplay/generic_hit_blood.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
				
				Timers:CreateTimer(1,function()
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
		knockback(self:GetCaster(),units[ 1 ])		
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
    local distance =500
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