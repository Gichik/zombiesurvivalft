pistol_shoot = class({})
endunit = nil

function pistol_shoot:OnSpellStart()
	--print("OnSpellStart")

	local target = self:GetCursorTarget()

	local info = {
			EffectName = "particles/units/heroes/hero_lina/lina_base_attack.vpcf",
			Ability = self,
			iMoveSpeed = 2500,
			Source = self:GetCaster(),
			Target = target,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
		}

	ProjectileManager:CreateTrackingProjectile( info )
	StartSoundEvent("Hero_Sniper.attack", self:GetCaster())
	self:GetCaster():Stop()	

end

--------------------------------------------------------------------------------

function pistol_shoot:OnProjectileHit( hTarget, vLocation )

	local ability = self
	local caster = ability:GetCaster()
	
	if hTarget:GetTeamNumber() ~= caster:GetTeamNumber() then
			ApplyDamage({ victim = hTarget, attacker = caster, damage = 20, damage_type = DAMAGE_TYPE_PHYSICAL })
	end

end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------