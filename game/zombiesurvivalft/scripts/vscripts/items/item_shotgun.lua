
if item_shotgun == nil then
    item_shotgun = class({})
end


function item_shotgun:GetBehavior() 
    local behavior = DOTA_ABILITY_BEHAVIOR_POINT
    return behavior
end

function item_shotgun:GetCooldown()
	local cooldown = self:GetSpecialValueFor("cooldown") 

	if IsServer() then
		local caster =  self:GetCaster()

		if caster and caster:HasAbility("shotgun_speed") then
			cooldown = 1.0
		end
	end
    return cooldown
end


function item_shotgun:OnSpellStart()
	--print("OnSpellStart")
	local caster = self:GetCaster()
	local hTarget = self:GetCursorPosition()

    if caster:HasItemInInventory("item_shotgun_ammo") then
    	RemoveAmmunition("item_shotgun_ammo",self)

		local point = hTarget
		
		vDirection = point - caster:GetAbsOrigin()
		vDirection = Vector(vDirection.x, vDirection.y, 0) --LIMIT MOTION TO ONLY ONE PLANE
		vDirection = vDirection:Normalized()


		local pID1 = ParticleManager:CreateParticle("particles/econ/events/league_teleport_2014/teleport_end_dust_league.vpcf", PATTACH_ABSORIGIN, caster)

		Timers:CreateTimer(3,function()
			ParticleManager:DestroyParticle(pID1, false)
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
			fDistance = 250,
			Source = caster,
			iUnitTargetTeams = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetTypes = DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iVisionTeamNumber = caster:GetTeamNumber(),
			iVisionRadius = 65
		}
		self.first = 0
		ProjectileManager:CreateLinearProjectile( info )
		--EmitSoundOn("Hero_Sniper.MKG_attack", caster)
		EmitSoundOn("ZombieSurvivalFT.EffectShotgunShoot", caster)
		caster:Stop()
		UpgradeCaster(self)	
	end
end


function item_shotgun:OnProjectileHit( hTarget, vLocation )

	local caster = self:GetCaster()

	local units = FindUnitsInRadius( caster:GetTeamNumber(), vLocation, caster, 300,
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 0, #units do	
		if units[ i ] and units[ i ] ~= caster then  --DAMAGE UNIT
			if self.first == 0 then
				EmitSoundOn("Hero_Sniper.AssassinateDamage", units[ i ])
			end
			
		    local damageTable =
		    {
				victim = units[ i ],
				attacker = caster,
				damage = self:GetSpecialValueFor("damage"),
				damage_type = DAMAGE_TYPE_PHYSICAL
		    }	

			ApplyDamage(damageTable)
			ApplyKnockback(caster,units[ i ],self)
		end
	end
end


function RemoveAmmunition(ammoName,ability)
	local caster = ability:GetCaster()
	local item = nil
	local charges = 0
	local first = 0
	for i = 0, 8 do
		item = caster:GetItemInSlot(i)
		if item ~= nil then
			if item:GetAbilityName() == ammoName then
				if item:IsStackable() == true then
					if item:GetCurrentCharges() > 2 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-2)
						return nil
					else
						caster:RemoveItem(item)
						return nil
					end
				else
					caster:RemoveItem(item)
					return nil			
				end
			end
		end
	end	
end


function ApplyKnockback( caster, target, ability )

    target:RemoveModifierByName("modifier_knockback")	

	local center = caster:GetAbsOrigin()
    local knockbackModifierTable =
    {
        should_stun = 1,
        knockback_duration = ability:GetSpecialValueFor("knockback_duration"),
        duration = ability:GetSpecialValueFor("knockback_duration"),
        knockback_distance = ability:GetSpecialValueFor("knockback_distance"),
        knockback_height = 0,
        center_x = center.x,
        center_y = center.y,
        center_z = center.z,
    }		

   --target:EmitSound("Hero_NyxAssassin.Impale.Target")
    target:AddNewModifier(caster, nil, "modifier_knockback", knockbackModifierTable)
end

function UpgradeCaster(ability)
	local caster = ability:GetCaster()

	if not caster.shotgun_use_count then
		caster.shotgun_use_count = 1
	else
		if caster.shotgun_use_count == 15 then
			AddShotgunAbility("shotgun_speed",caster)
		end
		caster.shotgun_use_count = caster.shotgun_use_count + 1
	end
end

function AddShotgunAbility(name,caster)
	if not caster:FindAbilityByName(name) then
		for i = 0, 12 do
			if not caster:GetAbilityByIndex(i) then
				local ability = caster:AddAbility(name)
				ability:SetLevel(1)
				return nil
			end
		end
	end
end