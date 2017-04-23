
if item_pistol == nil then
    item_pistol = class({})
end


function item_pistol:GetBehavior() 
    local behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    return behavior
end

--[[
function item_pistol:GetManaCost() 
	local mana = 0
    if self:GetCaster():HasItemInInventory("item_pistol_ammo") then
    	mana = self:GetSpecialValueFor("manna_cost")
    end
    return mana
end


function item_pistol:GetCooldown() 
	local cooldown = 0
    if self:GetCaster():HasItemInInventory("item_pistol_ammo") then
    	cooldown = self:GetSpecialValueFor("cooldown")
    end
    return cooldown
end
]]

function item_pistol:OnSpellStart()
	--print("OnSpellStart")
	local caster = self:GetCaster()
	local hTarget = false

    if not self:GetCursorTargetingNothing() then
        hTarget = self:GetCursorTarget()
    end

    if caster:HasItemInInventory("item_pistol_ammo") then
    	RemoveAmmunition("item_pistol_ammo",self)

		local info = {
				EffectName = "particles/units/heroes/hero_lina/lina_base_attack.vpcf",
				Ability = self,
				iMoveSpeed = 2500,
				Source = caster,
				Target = hTarget,
				iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2
			}

		ProjectileManager:CreateTrackingProjectile( info )
		EmitSoundOn("Hero_Sniper.attack", caster)
		caster:Stop()
		UpgradeCaster(self)	
	end
end


function item_pistol:OnProjectileHit( hTarget, vLocation )

	local caster = self:GetCaster()


	--if hTarget:GetTeamNumber() ~= caster:GetTeamNumber() then

		
		local dmg = self:GetSpecialValueFor("damage")
		if caster:HasAbility("pistols_accuracy") then
			dmg = dmg + caster:FindAbilityByName("pistols_accuracy"):GetSpecialValueFor("bonus_damage")
		end

	    local damageTable =
	    {
			victim = hTarget,
			attacker = caster,
			damage = dmg,
			damage_type = DAMAGE_TYPE_PHYSICAL
	    }
		

		ApplyDamage(damageTable)
		ApplyKnockback(caster,hTarget,self)
	--end
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
					if item:GetCurrentCharges() > 1 then
						charges = item:GetCurrentCharges()
						item:SetCurrentCharges(charges-1)
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

	if not caster.pistol_use_count then
		caster.pistol_use_count = 1
	else
		if caster.pistol_use_count == 20 then
			AddPistolsAbility("pistols_accuracy",caster)
		end
		caster.pistol_use_count = caster.pistol_use_count + 1
	end
end

function AddPistolsAbility(name,caster)
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