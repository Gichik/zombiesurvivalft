run_chainsaw = class({})
LinkLuaModifier( "modifier_slow_moved","modifiers/modifier_slow_moved.lua", LUA_MODIFIER_MOTION_NONE )
first = 0
--print("run_chainsaw")
function run_chainsaw:OnSpellStart()

	local caster = self:GetCaster()
	local point = self:GetCaster():GetAbsOrigin() + (self:GetCaster():GetForwardVector() * 200)	
	
	vDirection = point - caster:GetAbsOrigin()
	vDirection = Vector(vDirection.x, vDirection.y, 0) --LIMIT MOTION TO ONLY ONE PLANE
	vDirection = vDirection:Normalized()
	
	local info = {
		EffectName	= "particles/units/heroes/hero_shredder/shredder_chakram.vpcf",
		Ability = self,
		Source = caster,
		vSpawnOrigin = caster:GetAbsOrigin(),
		vVelocity = vDirection * 900 * 0.7, -- EFFECT TRAVELS TOO FUCKING FAST
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
	StartSoundEvent("Hero_Shredder.Chakram.Target", self:GetCaster())
	self:GetCaster():Stop()	

end

function run_chainsaw:OnProjectileThink(vLocation)

	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), vLocation, self:GetCaster(), 300,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	if units[ i ] then  --DAMAGE UNIT
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
			damage = 10,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = this,
		}
		ApplyDamage( damage )
		units[ 1 ]:AddNewModifier(self:GetCaster(), self, "modifier_slow_moved", { duration = 1 } )		
		first = 1

	end
	

end
