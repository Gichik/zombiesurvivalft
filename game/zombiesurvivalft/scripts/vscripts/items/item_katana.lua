
if item_katana == nil then
    item_katana = class({})
end


function item_katana:GetBehavior() 
    local behavior = DOTA_ABILITY_BEHAVIOR_POINT
    return behavior
end


function item_katana:GetAbilityTextureName(brokenAPI)
  return self.BaseClass.GetAbilityTextureName( self )
end

function item_katana:OnSpellStart()
	--print("OnSpellStart")
	local caster = self:GetCaster()
	local hTarget = self:GetCursorPosition()
	local point = hTarget
	
	vDirection = point - caster:GetAbsOrigin()
	vDirection = Vector(vDirection.x, vDirection.y, 0) --LIMIT MOTION TO ONLY ONE PLANE
	vDirection = vDirection:Normalized()

	local pID1 = ParticleManager:CreateParticle("particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(pID1, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControlForward(pID1, 0, caster:GetForwardVector()*(-1))

	Timers:CreateTimer(1,function()
		ParticleManager:DestroyParticle(pID1, false)
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
	self.first = 0
	ProjectileManager:CreateLinearProjectile( info )
	EmitSoundOn("Hero_Axe.CounterHelix", caster)
	caster:Stop()
	item_katana:UpgradeCaster(self)		
end


function item_katana:OnProjectileHit( hTarget, vLocation )

	local caster = self:GetCaster()

	local dmg = self:GetSpecialValueFor("damage")
	if caster:HasAbility("skilful_master") then
		dmg = dmg + caster:FindAbilityByName("skilful_master"):GetSpecialValueFor("bonus_damage")
	end

	local units = FindUnitsInRadius( caster:GetTeamNumber(), vLocation, caster, 200,
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
	
	for i = 0, #units do				
		if units[ i ] and units[ i ] ~= caster and units[ i ]:HasModifier("modifier_vulnerability_to_common") then  --DAMAGE UNIT
			if self.first == 0 then
				EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", units[ i ])
			end
			
		    local damageTable =
		    {
				victim = units[ i ],
				attacker = caster,
				damage = dmg,
				damage_type = DAMAGE_TYPE_PHYSICAL
		    }

			ApplyDamage(damageTable)
		end
	end
end

function item_katana:UpgradeCaster(ability)
	local caster = ability:GetCaster()

	if not caster.katana_use_count then
		caster.katana_use_count = 1
	else
		if caster.katana_use_count == 30 then
			AddKatanaAbility("skilful_master",caster)
		end
		caster.katana_use_count = caster.katana_use_count + 1
	end
end

function AddKatanaAbility(name,caster)
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