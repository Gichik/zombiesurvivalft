
LinkLuaModifier("modifier_zombie_anticipation", "modifiers/modifier_zombie_anticipation.lua", LUA_MODIFIER_MOTION_NONE )


function EffectsDestroyWood(data)
	local caster = data.caster
	StartSoundEventFromPosition("DOTA_Item.Maim",caster:GetAbsOrigin())
	ParticleManager:CreateParticle("particles/world_destruction_fx/tree_dire_destroy.vpcf", PATTACH_ABSORIGIN, caster)
end

function SetSpawnSettings(data)
	local unit = data.caster
	if not unit.vSpawnLoc then
		unit.vSpawnLoc = unit:GetAbsOrigin()
	end
	if not unit.vSpawnVector then
		unit.vSpawnVector = unit:GetForwardVector()
	end		
end

function MoobRespawn(data)

	local moob = data.caster
	local name = moob:GetUnitName()
	local SpawnLoc = moob.vSpawnLoc
	local SpawnVector = moob.vSpawnVector
	local team = moob:GetTeamNumber()
	local clearSpace = true

	if data.FindClearSpace == "0" then
		clearSpace = false
	end

	if (SpawnLoc == nil) then
		SpawnLoc = moob:GetOrigin()
	end

	if (SpawnVector == nil) then
		SpawnVector = Vector(0,-1,0)
	end

	GameRules:GetGameModeEntity():SetContextThink(string.format("RespawnThink_%d",moob:GetEntityIndex()), 
		function()
			local unit = CreateUnitByName(name, SpawnLoc, clearSpace, nil, nil, team )
			unit.vSpawnLoc = SpawnLoc 
			unit.vSpawnVector = SpawnVector
			unit:SetForwardVector(SpawnVector)
		end,
		data.Time)		
end



function BleedingDamage(data)
--print("BleedingDamage")
	local health = data.target:GetHealth()-4
	if health > 1 then
		data.target:SetHealth(health)
	else
		data.target:ForceKill(true)
		--FireGameEvent("dota_player_killed", {PlayerID = data.target:GetPlayerID(), HeroKill = true, TowerKill = false})
	end
end


function ZombieAnticipation(data)
	local unit = data.caster
	local ability = unit:FindAbilityByName("zombie_anticipation")
	if not unit:HasModifier("modifier_zombie_anticipation") then
		unit:SetBaseMoveSpeed(unit:GetBaseMoveSpeed() + ability:GetSpecialValueFor("bonus_move_speed"))
		unit:AddNewModifier(unit, ability, "modifier_zombie_anticipation", {duration = ability:GetSpecialValueFor("cooldown")})
	end
end


function ForceAttackCaster(data)
	local caster = data.caster
	local target = data.target

	target:SetForceAttackTarget(nil)

	if caster:IsAlive() then
		local order = 
		{
			UnitIndex = target:entindex(),
			OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
			TargetIndex = caster:entindex()
		}

		ExecuteOrderFromTable(order)
		target:SetForceAttackTarget(caster)
--[[
		local damage = {
			victim = caster,
			attacker = target,
			damage = 1,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			ability = nil,
		}
		ApplyDamage( damage )]]		
	else
		target:Stop()
		target:SetForceAttackTarget(nil)
	end

end


function ApplyModifierHeat(data)
	local activator = data.activator
	if not activator:HasModifier("modifier_heat") then
		activator:AddNewModifier(activator, nil, "modifier_heat", {})	
	end
end

function RemoveModifierHeat(data)
	local activator = data.activator
	if activator:HasModifier("modifier_heat") then
		activator:RemoveModifierByName("modifier_heat")	
	end
end

function TeleportHeroToBiom(data)
	local activator = data.activator
	if biome_number == 1 then
		main:MoveHeroToBiom(activator,"city") 
	end
	if biome_number == 2 then
		activator:AddNewModifier(activator, nil, "modifier_cold", {}) 
		main:MoveHeroToBiom(activator,"snow")
	end
	if biome_number == 3 then
		activator:AddNewModifier(activator, nil, "modifier_heat", {})
		main:MoveHeroToBiom(activator,"desert")
	end		
end

function MutantGrowl(data)
	local unit = data.caster
	EmitSoundOn("ZombieSurvivalFT.EffectVoiceMutant1", unit)
end