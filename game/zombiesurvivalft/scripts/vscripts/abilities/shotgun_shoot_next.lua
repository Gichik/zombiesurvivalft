shotgun_shoot_next = class({})
endunit = nil

function shotgun_shoot_next:OnSpellStart()
	--print("shotgun_shoot_next")
	

	
	
	local caster = self:GetCaster()
	--local target = self.target
	local point = self:GetCursorPosition()
	local range = 700
	local speed = 5000
	local frameTime = 0.02

	print(range)
	print(speed)

	local dmg = 40
	
	local currPos = caster:GetAbsOrigin()
	local startPos = caster:GetAbsOrigin()

	vDirection = point - caster:GetAbsOrigin()
	vDirection = Vector(vDirection.x, vDirection.y, 0) --LIMIT MOTION TO ONLY ONE PLANE
	vDirection = vDirection:Normalized()
	

	local info = {
		EffectName = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf",
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(), 
		vVelocity = vDirection * speed * 0.7, -- EFFECT TRAVELS TOO FUCKING FAST
		fStartRadius = 50,
		fEndRadius = 50,
		fDistance = 120,
		Source = caster,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		bProvidesVision = true,
		bDeleteOnHit = true,
		iVisionTeamNumber = caster:GetTeamNumber(),
		iVisionRadius = 65
	}
	nProjID = ProjectileManager:CreateLinearProjectile( info )
	StartSoundEvent("Hero_Sniper.MKG_attack", caster)




	Timers:CreateTimer( function()
		currPos = currPos + (vDirection * speed * frameTime)
		local diff = currPos - startPos
		local distance = (diff.x * diff.x) + (diff.y * diff.y)
		local units = FindUnitsInRadius( caster:GetTeamNumber(), currPos, caster, 200,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		if distance > (range * range) then --STOP IF GOING TOO FAR
			--ProjectileManager:DestroyLinearProjectile( nProjID )
			return nil
		elseif units[ 1 ] then  --DAMAGE UNIT
			local damage = {
				victim = units[ 1 ],
				attacker = caster,
				damage = dmg,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				ability = this,
			}
			ApplyDamage( damage )
			knockback(self:GetCaster(),units[ 1 ])
			local id1 = ParticleManager:CreateParticle("particles/items2_fx/soul_ring_blood.vpcf", PATTACH_ABSORIGIN, units[ 1 ])
			Timers:CreateTimer(1,function()
				ParticleManager:DestroyParticle(id1, false)
				return nil
			end)
			StartSoundEvent("Hero_Sniper.AssassinateDamage", units[ 1 ])
			--ProjectileManager:DestroyLinearProjectile( nProjID )
			return nil
		elseif GridNav:IsNearbyTree( currPos, 50, true ) then --DESTROY TREES
			GridNav:DestroyTreesAroundPoint( currPos, 55, true)
			StartSoundEventFromPosition("Hero_Sniper.ProjectileImpact", currPos)
			--ProjectileManager:DestroyLinearProjectile( nProjID )
			return nil
		else --NOTHING HAPPENS
			return frameTime
		end
		end
	)

end


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